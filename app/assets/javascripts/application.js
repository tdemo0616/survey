//= require webpack-bundle

import React from 'react';
import ReactDOM from 'react-dom';
import HelloWorld from './components/HelloWorld';

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <React.StrictMode>
            <HelloWorld />
        </React.StrictMode>,
        document.getElementById('root')
    );
});
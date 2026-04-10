module 0x5f547576750e4c5f98cc2fe4a1a011a0df9b70df1ab88cabd31ee7c70d2b28bf::suidead {
    struct SUIDEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SUIDEAD>(arg0, 6, b"SUIDEAD", b"SuiDead", b"Sui are now dead", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRsYDAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBcAAAABDzD/ERGCTNqm/k1XQPcOIvqf5N4tcwBWUDggiAMAAPAXAJ0BKoAAgAA+bTSWR6QjIiEoEwmAgA2JaQDWrve+UJiYg4cFGHmByJLc8B/m2TLNZxZIO1WZpCRRBFKTeVt9aYXN+ZUnueZGXkEzI/AmNH5m9sppYwbVh++s8gus95r+SwYSgJvOjum+5f/X/dgNPjjv/5Q4kXvQaDOcCDKB0A+mcPoGKorvGcVDPJV4IebNon/5AXcY0V3Mi67VJuuzESNz/bACaq95RXcplxWH2OZuxBWzfPJWi2Mo4cMFHJUn0Dk/6GAAAP76eQZbfVwFoNGfHKZaLUOntVJ7Xnf9GrRsjsfmVnCAeWOhMKbOY6zGHVShPN04vi8UTa4ytiucKeSlesLO16gLYUdcXwDaNTURaFR+tyCZAYhGogFoY13oDXDFmnKjE2DGNHg4laPDt35tJ+410VizHUcndbO4//GYJnlvxNKWGr1/Z87qv3PMsltYPPEcc8r7l7d7F5YJUemYC+wHcYSa9vyfCDx8LzxJh31XjoO0DfnW4LTcF/G1cdTjVTPrvkVDyCuLnhvZa6u/j6T1apHGj4IjKwU3mcknCS7amf7cOLeH0kqwjRk0rAeOKzE0NRckU+EDRiqHUuuayJ2o/bBRPNj1QQADsPzs4k4/a6BxOdNQ7T1Vl/cMAbhT9WK/ZsIY94KfvIkdvf8IT9jcEX4dzW6xVhvQcA/B3L3yE+qpDb9Adhl5u8GHhBwzEZ1JoR1TOV02iP2DqtkG5C6azeLU4iYr694SZBdULiiOFeEDuFwFt/SmJUag2pG946RzkQrhX05sDe/j48YRpgCyQDKYdGE8J1lL4BcyLAWZV8n4TzgCbQi7p5x8DWPjonhH3N65XLz9CNF1AJAEb/FrJO7ZWTWl3C4XUgBmGTd4fF60UPMAHSn2YaJb2jE4BY8cVIgDY2WHA3473HOm/l6CKVZGOK8tOjdJ0fqwOnkkyG7lm5szk7eN9lVvAJusGa8sAbrUWEwEcc/qhdNghwnVYjDDoxnOmpMIrgQMx2Bx3ZrnB3X3EaF5tj1zDcy7pb5yW6KHfLQQxNzrjNrAxAmWGFJsmq+4gdY7df9ClI8xSEthJKvMUrBm7WRuAhLJOVYEK8fxSZCu45BZcpADackRrmYAGg8fZX0ReGcEcvpWmVZvxpR6NDSxxCFm+oXRql5Y/O5l36npDCL79TYSs6DboxehDiVo8BT9SYScdFYLGAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


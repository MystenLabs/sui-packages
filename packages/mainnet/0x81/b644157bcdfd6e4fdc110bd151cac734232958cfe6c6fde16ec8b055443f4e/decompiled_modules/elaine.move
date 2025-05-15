module 0x81b644157bcdfd6e4fdc110bd151cac734232958cfe6c6fde16ec8b055443f4e::elaine {
    struct ELAINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELAINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELAINE>(arg0, 9, b"ELAINE", b"Elaine the Girl Pepe", x"456c61696e6520746865204769726c20506570652024454c41494e450a0a4d617474204675726965206372656174656420612064726177696e67206f66204769726c20506570652c206e616d65642022456c61696e652c22207768696368206865206578636c75736976656c7920736861726564206f6e206869732050617472656f6e206163636f756e74206f6e204a756e652032332c20323032312c2061732070617274206f6620636f6e74656e742072656c6174656420746f20746865202a4665656c7320476f6f64204d616e2a20646f63756d656e746172792e0a0a41206c6567697420616c7465726e61746520506570652066726f6d204d6174742046757269652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x4606dd2488d74f2cb07f5e50427a8c760d9c8183.png?size=xl&key=ccd1c4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELAINE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELAINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELAINE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


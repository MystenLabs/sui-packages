module 0xf7b326d185d5d15bd1b43d53d1cff09c2595ea298c7b2c339a9bf6725e6aab15::pusheecat {
    struct PUSHEECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSHEECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSHEECAT>(arg0, 6, b"Pusheecat", b"Pusheecat Pusheen", b"One Cat. Billions of Owners - Pusheen on the SUI NETWORK!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighat5vvzjfg4p3lgnlzhwlmtecwtjbrozqd3rcnnhfkybx4n2wyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSHEECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUSHEECAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


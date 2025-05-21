module 0x1016fb50288d8a855c08915a23d277e36248367eb37dd2b5188bed178e9be4e2::sharrkui {
    struct SHARRKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARRKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARRKUI>(arg0, 6, b"SHARRKUI", b"SHARKUI", b"SHARRKUI is not just meme and a crypto. But a revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3fyq4yeaslstheqzddxhwho4cs7u7opohrcola5vw6hqtmx64ui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARRKUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARRKUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xa3badf1ff73e931edfdbe8cdc830b1ad649f192453e3f632d50361f39f9d4ba8::fyoge {
    struct FYOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYOGE>(arg0, 6, b"Fyoge", b"Master Fyoge", b"Master Of yoge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjqt3taswwm7p23azti7nkfocelgitpabx4yv7e6aip77fgjijou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FYOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


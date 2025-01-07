module 0xe0ad779de6a96721dc995c0adfd48925591da3fee84acf01dac188bb043e9456::suiorca {
    struct SUIORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIORCA>(arg0, 6, b"SUIORCA", b"SUIRCA", b"SUIRCA THE BEST ORCA ON SUI NETWORK! READY TO BE THE META", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0827_3caa4258c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}


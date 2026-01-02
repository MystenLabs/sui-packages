module 0xc68c4cfb63d702227db09c28837e75abd23bbb3adc192e3bc45fecca4dd5b7e8::afc {
    struct AFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFC>(arg0, 6, b"AFC", b"Africoin", b"Connecting Africa using Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2415_04a3647ea3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFC>>(v1);
    }

    // decompiled from Move bytecode v6
}


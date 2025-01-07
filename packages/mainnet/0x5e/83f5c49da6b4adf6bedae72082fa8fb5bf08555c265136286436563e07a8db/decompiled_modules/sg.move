module 0x5e83f5c49da6b4adf6bedae72082fa8fb5bf08555c265136286436563e07a8db::sg {
    struct SG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SG>(arg0, 6, b"SG", b"SuiCideGirls", b"Beauty Redefined. Be a part of our community featuring alternative models from around the world! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/sg_f6abdf651f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x8fd18659ec3f6aacd4d39162293624a260a05b3e5755e6953e6c273e638d3193::we_need_freedom {
    struct WE_NEED_FREEDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE_NEED_FREEDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE_NEED_FREEDOM>(arg0, 6, b"FREEDOM", b"WE NEED FREEDOM", b"WE NEED FREEDOM is the future of decentralized finance. Community driven and transparent.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE_NEED_FREEDOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE_NEED_FREEDOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


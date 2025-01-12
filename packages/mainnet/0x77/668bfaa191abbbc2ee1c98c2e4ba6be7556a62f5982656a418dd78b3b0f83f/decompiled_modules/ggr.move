module 0x77668bfaa191abbbc2ee1c98c2e4ba6be7556a62f5982656a418dd78b3b0f83f::ggr {
    struct GGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGR>(arg0, 6, b"ggr", b"ggg", b"grgr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/eb8fd464-6990-4252-ab8a-ec0ebe37f2bd.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


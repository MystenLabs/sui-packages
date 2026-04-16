module 0x49d2965962c85bca54d18d1f638b0ee237d33ad44a9308a16aedb0a76d9a7243::lal_ray_rso_2026_04_26_rso_yes {
    struct LAL_RAY_RSO_2026_04_26_RSO_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAL_RAY_RSO_2026_04_26_RSO_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAL_RAY_RSO_2026_04_26_RSO_YES>(arg0, 0, b"LAL_RAY_RSO_2026_04_26_RSO_YES", b"LAL_RAY_RSO_2026_04_26_RSO YES", b"LAL_RAY_RSO_2026_04_26_RSO YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAL_RAY_RSO_2026_04_26_RSO_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAL_RAY_RSO_2026_04_26_RSO_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


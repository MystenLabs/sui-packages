module 0x453dffbef4a48eeb6d00d6233298e2d78e23c64e3c4424e0c261dd2ac1492376::gng {
    struct GNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNG>(arg0, 9, b"GNG", b"GINGER", b"WE LOVE CAT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GNG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNG>>(v1);
    }

    // decompiled from Move bytecode v6
}


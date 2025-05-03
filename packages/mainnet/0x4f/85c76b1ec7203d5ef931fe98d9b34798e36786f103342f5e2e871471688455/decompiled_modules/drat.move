module 0x4f85c76b1ec7203d5ef931fe98d9b34798e36786f103342f5e2e871471688455::drat {
    struct DRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAT>(arg0, 6, b"DRAT", b"Drunk Rat Club", b"The rudest and weirdest community of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/drunk_rat_logo_2bc728eef1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


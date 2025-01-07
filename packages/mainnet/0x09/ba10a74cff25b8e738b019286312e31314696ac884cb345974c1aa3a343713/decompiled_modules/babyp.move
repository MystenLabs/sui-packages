module 0x9ba10a74cff25b8e738b019286312e31314696ac884cb345974c1aa3a343713::babyp {
    struct BABYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYP>(arg0, 6, b"BABYP", b"Baby Peanut On Sui", b"Nuts for Fun, Squirreling Around Together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BABY_PEANUT_ICON_DEX_150x150_6af2c85b01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x5fd59d122121b2377c3250cb08caebc4093a1a7f0081a9932321eaa56c257f83::drippy {
    struct DRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPPY>(arg0, 6, b"Drippy", b"Drippy fans", b"The Association of People Who Love Drippy sui developers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0941_1a6acc9a62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


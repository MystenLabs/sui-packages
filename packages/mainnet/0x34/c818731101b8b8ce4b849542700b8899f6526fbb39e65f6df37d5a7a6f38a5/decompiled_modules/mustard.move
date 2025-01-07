module 0x34c818731101b8b8ce4b849542700b8899f6526fbb39e65f6df37d5a7a6f38a5::mustard {
    struct MUSTARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTARD>(arg0, 6, b"MUSTARD", b"MUSTAAAAAAARD", b"https://www.complex.com/music/a/backwoodsaltar/kendrick-lamar-mustard-tv-off-memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2o_KY_27_EJ_400x400_fc168ee9d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSTARD>>(v1);
    }

    // decompiled from Move bytecode v6
}


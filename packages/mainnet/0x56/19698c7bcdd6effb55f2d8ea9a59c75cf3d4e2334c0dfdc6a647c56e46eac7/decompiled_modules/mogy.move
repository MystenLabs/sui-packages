module 0x5619698c7bcdd6effb55f2d8ea9a59c75cf3d4e2334c0dfdc6a647c56e46eac7::mogy {
    struct MOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGY>(arg0, 6, b"MOGY", b"MOGY SUI", b"MOGY, the token that takes you beyond the stars! Inspired by adventure and space exploration, MOGY is more than just a memecoin, is a galactic community where cryptocurrency enthusiasts come together to celebrate creativity and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/002726ed_f9e7_4a85_9500_0846abbb688c_2e9c296b81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}


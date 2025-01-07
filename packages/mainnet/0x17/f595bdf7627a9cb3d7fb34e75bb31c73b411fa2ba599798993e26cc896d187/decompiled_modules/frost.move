module 0x17f595bdf7627a9cb3d7fb34e75bb31c73b411fa2ba599798993e26cc896d187::frost {
    struct FROST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROST>(arg0, 6, b"Frost", b"Frosthop", x"77686f20736179732066726f6773206861766520746f20626520677265656e3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_Avxe_T_Vi_400x400_8d3d02a4fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROST>>(v1);
    }

    // decompiled from Move bytecode v6
}


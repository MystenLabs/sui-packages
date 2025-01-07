module 0x5fdb04b7f4d7d32f6d6155ed39b5dbe3c6e79595d0298930e01fafaf9c491c7d::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 6, b"BLU", b"Mischief of SUI", b"Making waves, causing trouble, and always smilingBlus here to shake things up on SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ztw_Zc_W_Xw_Agfh_D_718effda9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLU>>(v1);
    }

    // decompiled from Move bytecode v6
}


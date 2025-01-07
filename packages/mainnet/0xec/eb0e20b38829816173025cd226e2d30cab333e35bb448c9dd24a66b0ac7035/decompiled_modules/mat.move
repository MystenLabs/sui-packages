module 0xeceb0e20b38829816173025cd226e2d30cab333e35bb448c9dd24a66b0ac7035::mat {
    struct MAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAT>(arg0, 6, b"MAT", b"Matteo on SUI", b"Ambassador of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HJ_Zj8z_Rl_400x400_e834297d25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


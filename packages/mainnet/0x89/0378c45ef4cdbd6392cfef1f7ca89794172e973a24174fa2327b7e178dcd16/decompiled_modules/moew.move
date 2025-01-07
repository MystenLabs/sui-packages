module 0x890378c45ef4cdbd6392cfef1f7ca89794172e973a24174fa2327b7e178dcd16::moew {
    struct MOEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOEW>(arg0, 6, b"MOEW", b"Meow Kingdom", b"The 1st social interaction game build on #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9a07ed13_1fd9_4b8c_847c_20b54ccc8f90_e8869bda1b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOEW>>(v1);
    }

    // decompiled from Move bytecode v6
}


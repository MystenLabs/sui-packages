module 0xe9f7b18eba4f9adb30a1718c827503c7c5f5be34725a7e451791aa9d49f5d510::suidimo {
    struct SUIDIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDIMO>(arg0, 6, b"SUIDIMO", b"DIMO on SUI", b"DIMO on SUI worlddddddddddddddddddddddddddddddddddddddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rm_Ce4f_BO_400x400_17db5e4322.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}


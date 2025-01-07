module 0x59272682164bdb0c0e6fbbe498baf5d40a00a5d14872eb9d09bde02dfe699e44::shrimple {
    struct SHRIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMPLE>(arg0, 6, b"SHRIMPLE", b"Make it SHRIMPLE", b"The crowned Shrimple in the SUI ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Td2m_TK_400x400_caa02c9052.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


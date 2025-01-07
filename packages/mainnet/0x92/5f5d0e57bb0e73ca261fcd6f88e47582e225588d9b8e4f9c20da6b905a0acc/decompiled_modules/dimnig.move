module 0x925f5d0e57bb0e73ca261fcd6f88e47582e225588d9b8e4f9c20da6b905a0acc::dimnig {
    struct DIMNIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIMNIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIMNIG>(arg0, 6, b"DIMNIG", b"DIMAS BLACK", b"double money man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zfd2_las_A_Als_a_99af60cbe5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIMNIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIMNIG>>(v1);
    }

    // decompiled from Move bytecode v6
}


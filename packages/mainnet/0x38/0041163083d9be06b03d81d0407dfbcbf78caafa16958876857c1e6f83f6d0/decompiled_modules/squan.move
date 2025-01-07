module 0x380041163083d9be06b03d81d0407dfbcbf78caafa16958876857c1e6f83f6d0::squan {
    struct SQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAN>(arg0, 6, b"SQUAN", b"Sui Quan", x"4669727374204368696e65736520646f67206f6e20737569200a0a427579626f74206c697665202040536875695175616e427579426f740a0a53756920546f6f6c7320636f6d696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026508_ca999e6c95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


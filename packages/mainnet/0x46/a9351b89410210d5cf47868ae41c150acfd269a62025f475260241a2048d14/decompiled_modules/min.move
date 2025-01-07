module 0x46a9351b89410210d5cf47868ae41c150acfd269a62025f475260241a2048d14::min {
    struct MIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIN>(arg0, 6, b"MIN", b"MINION ON SUI", x"4d494e494f4e20434f494e204f4e205355490a53594d424f4c3a20244d494e494f4e0a535550504c593a203136342e3230302e3030302e3030302e3030300a5441583a20302f30200a52454e4f554e434544204245464f5245204c41554e43480a31303025204c50204255524e4544204245464f5245204c41554e43480a0a425559204e4f57205748454e2049542043484541500a20576562736974653a202068747470733a2f2f6d696e696f6e2d636f696e2e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_I_Ep_YK_Cr_400x400_7b7ebfaea1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


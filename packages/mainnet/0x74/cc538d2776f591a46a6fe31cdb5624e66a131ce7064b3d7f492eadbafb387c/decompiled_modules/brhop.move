module 0x74cc538d2776f591a46a6fe31cdb5624e66a131ce7064b3d7f492eadbafb387c::brhop {
    struct BRHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRHOP>(arg0, 6, b"BRHOP", b"BROKENHOP", b"THE FIRST HOP IS BROKEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Broken_Hop_738aba3be7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa8d9b8b125e46ad3fb58c758711c599d5a65e4999ea7288bae2315673f04e7c6::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 6, b"SUIPERMAN", b"SUIPERMAAN", b"it's a plane, it's a bird, no is SUIPERMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xa8b69040684d576828475115b30cc4ce7c7743eab9c7d669535ee31caccef4f5_suiman_suiman_7de8f30cbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x49a95ea253f5e858eed72639e00cd4175ba95e994fa2ba8cba94e2f1234b2fe5::suia {
    struct SUIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIA>(arg0, 6, b"SUIA", b"Suia", b"suia.io . SocialFi on SUI! p", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Azvm_nf_400x400_120e9062c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIA>>(v1);
    }

    // decompiled from Move bytecode v6
}


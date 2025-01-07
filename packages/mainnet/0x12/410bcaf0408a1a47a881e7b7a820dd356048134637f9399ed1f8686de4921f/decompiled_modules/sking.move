module 0x12410bcaf0408a1a47a881e7b7a820dd356048134637f9399ed1f8686de4921f::sking {
    struct SKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKING>(arg0, 6, b"Sking", b"Sea King", b"Me and my Sea family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZT_Cn9d_XQAA_3_H_Qn_b6ff4da913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKING>>(v1);
    }

    // decompiled from Move bytecode v6
}


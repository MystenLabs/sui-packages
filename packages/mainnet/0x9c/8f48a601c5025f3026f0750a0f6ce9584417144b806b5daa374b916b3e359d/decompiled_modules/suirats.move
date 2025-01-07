module 0x9c8f48a601c5025f3026f0750a0f6ce9584417144b806b5daa374b916b3e359d::suirats {
    struct SUIRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRATS>(arg0, 6, b"SUIRATS", b"SUI RATS", b"RATSCOIN ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6872966_C_AD_45_4_EDE_8_F7_D_DA_3_B8_FCA_4456_3706742bd5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}


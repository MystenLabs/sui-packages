module 0xa6016d83a107d8fa83076af63c915987237a29098e1438cc54abdbf75c9f27d9::stray {
    struct STRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAY>(arg0, 6, b"STRAY", b"STRAYCAT ON SUI", x"57656c636f6d6520746f20245354524159202d205468652054616c65206f6620616e20416476656e7475726f757320436174210a456d6261726b206f6e20616e20616476656e747572652077697468206f75722062726176652073747261792063617420616e6420756e726176656c206578636974696e67206d7973746572696573210a0a4665656c206672656520746f20636f6e6e65637420616e6420736861726520796f75722073746f7269657320776974682065766572796f6e65210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_2_5cb30d25f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}


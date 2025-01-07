module 0xc1e0f43c029fb399a6cfc0d57bb36c7541a2e25b61b403b1f495bc4bd225e68b::negroinu {
    struct NEGROINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGROINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGROINU>(arg0, 6, b"NEGROINU", b"STOP CREATING SUISINU TOKEN SCAM BITCH", b"FUCKFUCK FUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image0_e307f5d7fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGROINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEGROINU>>(v1);
    }

    // decompiled from Move bytecode v6
}


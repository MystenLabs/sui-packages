module 0xaa5fb26b0c31babc63d733dd4297ecb9a47004410ff79298db0e239b011e791a::suinvy {
    struct SUINVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINVY>(arg0, 6, b"SUINVY", b"SUI NVY", b"NVY is the hype memecoin on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihw3cxclwmvkqhd7knrj4x6yfuvc5lpl3olqdrsahmjspk6qtfccm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINVY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


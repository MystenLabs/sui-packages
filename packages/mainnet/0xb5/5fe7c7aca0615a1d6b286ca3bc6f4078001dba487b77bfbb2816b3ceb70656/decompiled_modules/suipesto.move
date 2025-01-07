module 0xb55fe7c7aca0615a1d6b286ca3bc6f4078001dba487b77bfbb2816b3ceb70656::suipesto {
    struct SUIPESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPESTO>(arg0, 6, b"SUIPESTO", b"KING PESTO", b"BABY PENG PESTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3509_dfaaaf2945.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}


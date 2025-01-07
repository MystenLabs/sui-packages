module 0xd6dfc24fec198690c91b44d6d55251f9a90f6446882512507d57954a2687d63e::suri {
    struct SURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURI>(arg0, 6, b"SURI", b"Suri the meerkat", b"Suri is the smartest meerkat on the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suriiiii_f54ed29c4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURI>>(v1);
    }

    // decompiled from Move bytecode v6
}


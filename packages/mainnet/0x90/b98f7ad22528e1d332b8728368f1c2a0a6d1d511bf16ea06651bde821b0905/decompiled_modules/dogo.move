module 0x90b98f7ad22528e1d332b8728368f1c2a0a6d1d511bf16ea06651bde821b0905::dogo {
    struct DOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGO>(arg0, 6, b"DOGO", b"SUIDOGO", x"4120666c7566667920626c756520646f676f2c20726561647920746f20636f6e71756572205355492077697468206120737072696e6b6c65206f662061646f7261626c652064657465726d696e6174696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/cde_573115a47f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}


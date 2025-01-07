module 0xcda5c5c551c19de92470fe7a4bdb18283f4ca365dac2e9596257edbe2d4d5620::ork {
    struct ORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORK>(arg0, 6, b"ORK", b"ORKA", x"4865206973206e6f74206a757374207468652072756c6572206f662074686520736561732e2054686520736f6c652072756c6572206f6620746865206d61726b65742068617320617272697665642c204f726b610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_01716f9a37.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORK>>(v1);
    }

    // decompiled from Move bytecode v6
}


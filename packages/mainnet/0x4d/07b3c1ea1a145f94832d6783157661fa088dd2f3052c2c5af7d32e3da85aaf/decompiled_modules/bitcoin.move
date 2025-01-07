module 0x4d07b3c1ea1a145f94832d6783157661fa088dd2f3052c2c5af7d32e3da85aaf::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 6, b"Bitcoin", b"Suitoshi Nakamoto", b"$Bitcoin on $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71639624_A73_B_4547_95_AC_39_DD_131_AFD_9_B_dcd2023f58.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xfc7f4a147057c976049bfb7b3f547742cfd1436ee5bdfdcd9ce506325ac83e4e::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 6, b"CRAB", b"Sui Crab", b"$CRAB - The meme coin that's all about claws, coins, and fun. Ready to cap your gains?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_BE_64_E14_E5_AE_4_D6_E_842_D_90_CD_1_BE_26284_ea00116d3d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}


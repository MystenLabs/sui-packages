module 0xa5ca25d5a7a5b7b8541579049f48e9b9445505d569b75c639a9209afebafa328::pape {
    struct PAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPE>(arg0, 6, b"PAPE", b"PAPE ON SUI", b"$PAPE The OG meme will become the father of Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w6_Yc_T_Xp_A_400x400_57f5bd8f0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


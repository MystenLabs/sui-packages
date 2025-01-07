module 0xc0d6a745d36ee60b8c309387b3b0165cebf1019a17f0c79d0fbd0bcc382f2da1::tosui {
    struct TOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSUI>(arg0, 6, b"TOSUI", b"TOSUI on SUI", b"The Face of SUI, a beloved cat named after Satoshi Nakamoto. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/853j_Fdr_N_400x400_39e2d363b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


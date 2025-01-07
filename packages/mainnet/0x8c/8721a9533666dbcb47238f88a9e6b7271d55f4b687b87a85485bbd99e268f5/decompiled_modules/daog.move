module 0x8c8721a9533666dbcb47238f88a9e6b7271d55f4b687b87a85485bbd99e268f5::daog {
    struct DAOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOG>(arg0, 6, b"DAOG", b"SuiDaog", b"$DAOG MEME COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000349_6a632715b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


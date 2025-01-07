module 0x624463a56e9a7576232863f17849a88d1b4ac949d1cf76c87df2cd6e97d18a9b::fkof {
    struct FKOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKOF>(arg0, 6, b"FKOF", b"F**k off", x"20225768656e20746865792073617920274d656d6520436f696e73206172652061206a6f6b65272e2e2e220a2022596f75206a757374207361792027462a2a6b204f6666272e2e2e20616e64207761746368206974206d6f6f6e2022", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/079d9f34_b7b9_4e71_a234_5d5286d348b7_3347b9a71e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FKOF>>(v1);
    }

    // decompiled from Move bytecode v6
}


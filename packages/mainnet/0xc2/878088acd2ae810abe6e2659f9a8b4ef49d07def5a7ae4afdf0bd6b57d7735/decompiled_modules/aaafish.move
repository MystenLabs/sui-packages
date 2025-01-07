module 0xc2878088acd2ae810abe6e2659f9a8b4ef49d07def5a7ae4afdf0bd6b57d7735::aaafish {
    struct AAAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFISH>(arg0, 6, b"AAAfish", b"aaaFish", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732144100469.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


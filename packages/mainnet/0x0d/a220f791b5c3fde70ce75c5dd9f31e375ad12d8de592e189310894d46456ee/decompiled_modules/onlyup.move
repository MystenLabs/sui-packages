module 0xda220f791b5c3fde70ce75c5dd9f31e375ad12d8de592e189310894d46456ee::onlyup {
    struct ONLYUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYUP>(arg0, 6, b"ONLYUP", b"BROKER", b"Go UP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AEB_6_B914_604_A_4_BF_7_867_B_EC_0986260_C10_59a757444a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


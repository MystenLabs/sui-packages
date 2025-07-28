module 0x3cb1572c3bba5bb183683f4b34baffe3439f66a745d0bb2b5714983206894369::wetc {
    struct WETC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WETC>(arg0, 6, b"WETC", b"WETCOIN", b"Stake. Splash. Soak it in. WETCOIN is here on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/wetssss_196db41ad6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WETC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


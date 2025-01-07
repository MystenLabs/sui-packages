module 0x344f30aa1610011c9b5be19fafd5ee094ce28000c7617af777144836b258e4da::suchi {
    struct SUCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCHI, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 599 || 0x2::tx_context::epoch(arg1) == 600, 1);
        let (v0, v1) = 0x2::coin::create_currency<SUCHI>(arg0, 6, b"$UCHI", b"CRONICLES OF SUI", x"5361766f722074686520666c61766f722c20636174636820746865207761766520e28093202455434849206973206865726520746f2073657276652075702065706963206761696e7321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreibu5rg6cxet2oxd7g236ggk53mv6y2s5soyoan7vicobu3zo5frpa.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUCHI>(&mut v2, 420000000000000, @0x1482101e8cbd7671fc41b7f9310f6e5b3fcf6231eff4ef2f28b8b403f6d59387, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCHI>>(v2, @0x1482101e8cbd7671fc41b7f9310f6e5b3fcf6231eff4ef2f28b8b403f6d59387);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


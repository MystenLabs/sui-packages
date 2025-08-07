module 0xdba3a53d7cb18f599527110ba736814b4b335e024a7020e91a1465a36d1a2f8c::neca {
    struct NECA has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NECA>, arg1: 0x2::coin::Coin<NECA>) {
        assert!(false == false, 100);
        0x2::coin::burn<NECA>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NECA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<NECA>(0x2::coin::supply<NECA>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<NECA>>(0x2::coin::mint<NECA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NECA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NECA>(arg0, 5, b"NECA", b"Necas walletnt Coin", b"Neca's coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/YVu09RvWNkU69DqQC6UtT9Z9Kg7uzwJj_k2K06WqUQA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NECA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NECA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


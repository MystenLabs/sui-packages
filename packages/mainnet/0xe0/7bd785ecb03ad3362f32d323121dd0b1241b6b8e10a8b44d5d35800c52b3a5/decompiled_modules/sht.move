module 0xe07bd785ecb03ad3362f32d323121dd0b1241b6b8e10a8b44d5d35800c52b3a5::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<SHT>, arg1: &mut 0x2::coin::Coin<SHT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SHT>(arg0, 0x2::coin::split<SHT>(arg1, arg2, arg3));
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 9, b"SHT", b"SuiHub Token", b"SuiHub Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreic5dtwz67yiouukpdcbl6d3m6raiw5pat7dqr4df2othtlzr6ynbq.ipfs.nftstorage.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHT>(&mut v2, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


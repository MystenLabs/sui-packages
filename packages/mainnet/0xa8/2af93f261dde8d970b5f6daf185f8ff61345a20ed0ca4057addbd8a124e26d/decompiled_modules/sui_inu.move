module 0xa82af93f261dde8d970b5f6daf185f8ff61345a20ed0ca4057addbd8a124e26d::sui_inu {
    struct SUI_INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_INU>(arg0, 6, b"SINU", b"Sui Inu", b"telegram: SuiInucoin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_INU>>(v1);
        0x2::coin::mint_and_transfer<SUI_INU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_INU>>(v2);
    }

    // decompiled from Move bytecode v6
}


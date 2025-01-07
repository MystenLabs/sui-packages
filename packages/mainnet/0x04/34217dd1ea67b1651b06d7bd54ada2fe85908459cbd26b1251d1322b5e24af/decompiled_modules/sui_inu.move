module 0x434217dd1ea67b1651b06d7bd54ada2fe85908459cbd26b1251d1322b5e24af::sui_inu {
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


module 0xc0d761079b1e7fa4dbd8a881b7464cf8c400c0de72460fdf8ca44e3f1842715e::sui_inu {
    struct SUI_INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_INU>(arg0, 6, b"SINU", b"Sui Inu", b"telegram: SuiInucoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/12nQvFk/photo-2023-05-03-11-37-20.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_INU>>(v1);
        0x2::coin::mint_and_transfer<SUI_INU>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_INU>>(v2);
    }

    // decompiled from Move bytecode v6
}


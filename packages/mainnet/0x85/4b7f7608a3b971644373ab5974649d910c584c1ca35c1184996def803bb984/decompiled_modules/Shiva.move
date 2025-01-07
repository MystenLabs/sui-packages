module 0x854b7f7608a3b971644373ab5974649d910c584c1ca35c1184996def803bb984::Shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIVA>(arg0, 6, b"ShivaCoin", b"LAUNCH ON MAY 10", b"https://www.geckoterminal.com/", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


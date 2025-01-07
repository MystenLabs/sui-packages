module 0x8c4f43e0e9253af38509142f4e4572d8e2cb1a14ee46ad28aa7c4cd924250d85::dogwifsui {
    struct DOGWIFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFSUI>(arg0, 8, b"DOGWIFSUI", b"Yep", b"Yep", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGWIFSUI>(&mut v2, 9999999900000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


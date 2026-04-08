module 0x7c7fdaa26494306d2a1746dad2c4625df812177be3f73829ae794d6bb57547a9::pengu_gold {
    struct PENGU_GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU_GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU_GOLD>(arg0, 9, b"Pengu", b"Pengu Gold", b"pengu rich peapol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775682435532-1825ee330ccc14c7696211e118b359ec.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGU_GOLD>>(0x2::coin::mint<PENGU_GOLD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGU_GOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU_GOLD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


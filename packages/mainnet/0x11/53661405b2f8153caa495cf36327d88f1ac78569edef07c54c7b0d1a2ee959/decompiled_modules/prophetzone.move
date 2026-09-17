module 0x1153661405b2f8153caa495cf36327d88f1ac78569edef07c54c7b0d1a2ee959::prophetzone {
    struct PROPHETZONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROPHETZONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROPHETZONE>(arg0, 9, b"PROPHET", b"ProphetZone", b"Prophetzonei Now Live on sui chain buy and go to website mint your nft and enjoy with ur profit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1789656434780-8ef18107ad0a6f2438cd90471ac4a77e.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PROPHETZONE>>(0x2::coin::mint<PROPHETZONE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROPHETZONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROPHETZONE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


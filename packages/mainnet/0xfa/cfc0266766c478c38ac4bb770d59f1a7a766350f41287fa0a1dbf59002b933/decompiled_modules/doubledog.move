module 0xfacfc0266766c478c38ac4bb770d59f1a7a766350f41287fa0a1dbf59002b933::doubledog {
    struct DOUBLEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUBLEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUBLEDOG>(arg0, 6, b"DOUBLEDOG", b"Double Dog Meme", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOUBLEDOG>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOUBLEDOG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOUBLEDOG>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0x69b79e13673b9ec29e5010dc761177ce6adc4db5a6b93b8f284d081ab569b636::ufkm9fl {
    struct UFKM9FL has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFKM9FL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFKM9FL>(arg0, 0, b"UFKM9FL", b"Sui Blue Gift User FKM9FL", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UFKM9FL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UFKM9FL>>(0x2::coin::mint<UFKM9FL>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFKM9FL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


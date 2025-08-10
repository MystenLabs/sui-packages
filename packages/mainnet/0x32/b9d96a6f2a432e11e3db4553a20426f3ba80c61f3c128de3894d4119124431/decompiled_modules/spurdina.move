module 0x32b9d96a6f2a432e11e3db4553a20426f3ba80c61f3c128de3894d4119124431::spurdina {
    struct SPURDINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPURDINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPURDINA>(arg0, 6, b"SPURDINA", b"Spurdina on Sui", x"57656c636f6d6520746f20746865205370757264696e610a46726f6d20535549206368616f74696320594f4c4f20726169647320746f206461206465657020696e766173696f6e732c6d6f76656d656e740a45766572792053707572646f206e656564732061205370757264696e61205370757264696e61206b6565707320646120666c616d6520616c697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig2bqtnr4clnnyplrwso67wcydp223ulcbrjsjscafosntvt24nim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPURDINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPURDINA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


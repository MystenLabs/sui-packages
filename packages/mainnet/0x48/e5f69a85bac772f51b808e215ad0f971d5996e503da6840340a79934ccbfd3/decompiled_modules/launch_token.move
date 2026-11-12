module 0x48e5f69a85bac772f51b808e215ad0f971d5996e503da6840340a79934ccbfd3::launch_token {
    struct LAUNCH_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUNCH_TOKEN>(arg0, 0, b"RIP", b"Riptide", b"Ripping...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/6JbliGXYCGqn_-YqZbVrWp2i2cdajtnWJ4DeIEMxSac")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAUNCH_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCH_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


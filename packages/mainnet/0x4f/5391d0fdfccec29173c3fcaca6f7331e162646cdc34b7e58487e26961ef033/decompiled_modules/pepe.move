module 0x4f5391d0fdfccec29173c3fcaca6f7331e162646cdc34b7e58487e26961ef033::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPEDOGE", b"PEPEDOGE", b"PEPEDOGE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::coin::mint_and_transfer<PEPE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE>>(v2);
    }

    // decompiled from Move bytecode v6
}


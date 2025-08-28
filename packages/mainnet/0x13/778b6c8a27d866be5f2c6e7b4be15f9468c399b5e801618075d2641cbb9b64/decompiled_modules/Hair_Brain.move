module 0x13778b6c8a27d866be5f2c6e7b4be15f9468c399b5e801618075d2641cbb9b64::Hair_Brain {
    struct HAIR_BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIR_BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIR_BRAIN>(arg0, 9, b"BRAIR", b"Hair Brain", b"hairy brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzXGW5pXcAAohu7?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAIR_BRAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIR_BRAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


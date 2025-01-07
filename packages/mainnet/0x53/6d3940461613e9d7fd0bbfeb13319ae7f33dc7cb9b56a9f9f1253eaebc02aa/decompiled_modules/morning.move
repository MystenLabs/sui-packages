module 0x536d3940461613e9d7fd0bbfeb13319ae7f33dc7cb9b56a9f9f1253eaebc02aa::morning {
    struct MORNING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MORNING>, arg1: 0x2::coin::Coin<MORNING>) {
        0x2::coin::burn<MORNING>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MORNING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MORNING>>(0x2::coin::mint<MORNING>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MORNING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORNING>(arg0, 9, b"morning", b"MORNING", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"test token")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORNING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORNING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


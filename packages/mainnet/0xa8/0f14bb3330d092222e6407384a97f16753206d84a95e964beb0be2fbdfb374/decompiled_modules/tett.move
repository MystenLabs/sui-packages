module 0xa80f14bb3330d092222e6407384a97f16753206d84a95e964beb0be2fbdfb374::tett {
    struct TETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETT>(arg0, 4, b"TETT", b"Test token", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/ae19dfb0-d95a-11ef-a74b-b3b817eed47e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETT>>(v1);
        0x2::coin::mint_and_transfer<TETT>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


module 0xe45823a51e33d28d5640b80a8fbde6afa2088a4200282eb543c1dea68c1851a2::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 2, b"SQUIRT", b"SQUIRTLE", b"Squirtle coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/cND1tbf.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRTLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUIRTLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


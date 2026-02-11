module 0xde61fa661e46dfc34e49b5fa9649184b09e388535acb5b5b4f90368ba7ee80e0::claw {
    struct CLAW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAW>, arg1: 0x2::coin::Coin<CLAW>) {
        0x2::coin::burn<CLAW>(arg0, arg1);
    }

    fun init(arg0: CLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAW>(arg0, 6, b"CLHT", b"Claw", b"Claws of Strength, Heart of Humanity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyHtIQR.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0x68ba634d3cacf25aef459c96f6ca39ba6c3c6467459793562d48f04817d50e1e::FUTURE {
    struct FUTURE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUTURE>, arg1: 0x2::coin::Coin<FUTURE>) {
        0x2::coin::burn<FUTURE>(arg0, arg1);
    }

    fun init(arg0: FUTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTURE>(arg0, 9, b"FUTU", b"FUTURE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/rtXpGCB/future.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUTURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUTURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUTURE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FUTURE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0xf6bc7534741061da3b4dae0f7029a2cfc298bbc853f4fba0b6f94cdd2dc2b52d::sidni {
    struct SIDNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDNI>(arg0, 6, b"SIDNI", b"SIDNI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://twitter.com/PigEveryHour/photo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIDNI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIDNI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


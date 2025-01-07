module 0xf518d9b3a566a6d5ededae9e6bb5b6c822bfeb227b2f0cb7cbd9f80ec42debe8::SUIFLOKI {
    struct SUIFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLOKI>(arg0, 9, b"SUIFLOKI", b"SUI FLOKI", b"SUIFLOKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1460394944477245447/6CJDOThO_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFLOKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLOKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIFLOKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIFLOKI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


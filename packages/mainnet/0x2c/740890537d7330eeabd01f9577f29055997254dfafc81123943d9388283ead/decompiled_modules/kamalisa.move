module 0x2c740890537d7330eeabd01f9577f29055997254dfafc81123943d9388283ead::kamalisa {
    struct KAMALISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALISA>(arg0, 6, b"KAMALISA", b"Kamalisa", b"$KAMALISA is the NEXT 1000x and the FIRST Kamala Harris and Lisa Simpson MemeCoin on SUI! The Simpsons have once again predicted the future, NOW President Kamala Harris!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722014907156_2a0b6342eac4d013a94b217091b7b318_ffa4308c17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALISA>>(v1);
    }

    // decompiled from Move bytecode v6
}


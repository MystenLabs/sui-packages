module 0xb465da5c57b1d75bda90fe7a770d32ad0d4169cd99c84e461678f8bdb8b82be1::memel {
    struct MEMEL has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMEL>, arg1: 0x2::coin::Coin<MEMEL>) {
        0x2::coin::burn<MEMEL>(arg0, arg1);
    }

    fun init(arg0: MEMEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEL>(arg0, 6, b"MMEL", b"memeL", b"memeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMEL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMEL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


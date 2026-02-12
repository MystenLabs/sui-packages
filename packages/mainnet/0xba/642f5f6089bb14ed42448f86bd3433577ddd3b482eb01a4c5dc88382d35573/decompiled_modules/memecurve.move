module 0xba642f5f6089bb14ed42448f86bd3433577ddd3b482eb01a4c5dc88382d35573::memecurve {
    struct MEMECURVE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMECURVE>, arg1: 0x2::coin::Coin<MEMECURVE>) {
        0x2::coin::burn<MEMECURVE>(arg0, arg1);
    }

    fun init(arg0: MEMECURVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECURVE>(arg0, 6, b"MMC", b"memecurve", b"memeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECURVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECURVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMECURVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMECURVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


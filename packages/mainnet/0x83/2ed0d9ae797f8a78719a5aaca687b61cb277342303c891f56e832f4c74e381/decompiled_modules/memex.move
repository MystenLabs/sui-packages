module 0x832ed0d9ae797f8a78719a5aaca687b61cb277342303c891f56e832f4c74e381::memex {
    struct MEMEX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMEX>, arg1: 0x2::coin::Coin<MEMEX>) {
        0x2::coin::burn<MEMEX>(arg0, arg1);
    }

    fun init(arg0: MEMEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEX>(arg0, 6, b"MMEX", b"memex", b"memeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMEX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0x2458c5b667bc0c4f6e4521997bf3116a1e3183f5c12366079d3378573b91f476::memek {
    struct MEMEK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEMEK>, arg1: 0x2::coin::Coin<MEMEK>) {
        0x2::coin::burn<MEMEK>(arg0, arg1);
    }

    fun init(arg0: MEMEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK>(arg0, 6, b"MMEK", b"memeK", b"memeeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_400x400.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEMEK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEMEK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


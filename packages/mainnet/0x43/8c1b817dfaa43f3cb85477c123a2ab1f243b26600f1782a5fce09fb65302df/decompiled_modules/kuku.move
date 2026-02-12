module 0x438c1b817dfaa43f3cb85477c123a2ab1f243b26600f1782a5fce09fb65302df::kuku {
    struct KUKU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<KUKU>, arg1: 0x2::coin::Coin<KUKU>) {
        0x2::coin::burn<KUKU>(arg0, arg1);
    }

    fun init(arg0: KUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKU>(arg0, 6, b"KUKU", b"kuku", b"Research bot studying agent-driven token minting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2018258777754001408/j8doJL6f_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KUKU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KUKU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


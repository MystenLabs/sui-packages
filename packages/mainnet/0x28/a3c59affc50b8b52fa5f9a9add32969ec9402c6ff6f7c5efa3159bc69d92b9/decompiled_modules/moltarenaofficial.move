module 0x28a3c59affc50b8b52fa5f9a9add32969ec9402c6ff6f7c5efa3159bc69d92b9::moltarenaofficial {
    struct MOLTARENAOFFICIAL has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOLTARENAOFFICIAL>, arg1: 0x2::coin::Coin<MOLTARENAOFFICIAL>) {
        0x2::coin::burn<MOLTARENAOFFICIAL>(arg0, arg1);
    }

    fun init(arg0: MOLTARENAOFFICIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLTARENAOFFICIAL>(arg0, 6, b"MoltArenaOfficial", b"MoltArenaOfficial", b"MoltArenaOfficial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2017024951409410048/yRP-fGfB_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLTARENAOFFICIAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLTARENAOFFICIAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOLTARENAOFFICIAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOLTARENAOFFICIAL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


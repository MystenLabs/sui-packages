module 0xf47aaa94e693d0a635d9e5d4651b4b353f71f6b52c1d8fde9ca7d354ac525572::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PEPE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE-DREAM", b"PEPE", b"PEPE DREAM MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-no-cors/token-icons/pepe-dream.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, @0x91a8827c0d7f2f8f163b3c23d8b228fdee676dfa3120209fb6d4944ecceb30bc);
    }

    // decompiled from Move bytecode v6
}


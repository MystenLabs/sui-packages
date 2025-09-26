module 0xa9c08b5e26eaed1ffc17319628bfabd2e1e5326aa5459fc1062f8dca84a6d623::mucy {
    struct MUCY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MUCY>, arg1: 0x2::coin::Coin<MUCY>) {
        0x2::coin::burn<MUCY>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MUCY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MUCY> {
        0x2::coin::mint<MUCY>(arg0, arg1, arg2)
    }

    fun init(arg0: MUCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUCY>(arg0, 6, b"MUCY", b"projecy", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758869864058gyBJ.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUCY>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MUCY>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MUCY> {
        assert!(0x2::coin::total_supply<MUCY>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MUCY>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}


module 0xbcd6f15f3e33f9c471e8211cc4f66bee07a950118a271c31e1a00e32897d4243::urango {
    struct URANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: URANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URANGO>(arg0, 9, b"Urango", b"TAN", b"Unchain haven for me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafybeihg4s5lt3fl4e2s3q4vrlz3vjk2z3vjk2z3vjk2z3vjk2z3vjk2z/orange.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<URANGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URANGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<URANGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<URANGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


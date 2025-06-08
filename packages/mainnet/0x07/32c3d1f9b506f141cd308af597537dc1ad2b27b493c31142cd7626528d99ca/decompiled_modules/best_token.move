module 0x732c3d1f9b506f141cd308af597537dc1ad2b27b493c31142cd7626528d99ca::best_token {
    struct BEST_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEST_TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BEST_TOKEN>>(0x2::coin::mint<BEST_TOKEN>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEST_TOKEN>(arg0, 9, b"BST", b"BestToken", b"The best token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEST_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


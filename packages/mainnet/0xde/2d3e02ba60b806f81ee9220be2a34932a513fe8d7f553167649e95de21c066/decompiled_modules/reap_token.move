module 0xde2d3e02ba60b806f81ee9220be2a34932a513fe8d7f553167649e95de21c066::reap_token {
    struct REAP_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REAP_TOKEN>, arg1: 0x2::coin::Coin<REAP_TOKEN>) {
        0x2::coin::burn<REAP_TOKEN>(arg0, arg1);
    }

    fun init(arg0: REAP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REAP_TOKEN>(arg0, 9, b"REAP", b"REAP", b"Reap Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.releap.xyz/reap_token.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REAP_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REAP_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REAP_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<REAP_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


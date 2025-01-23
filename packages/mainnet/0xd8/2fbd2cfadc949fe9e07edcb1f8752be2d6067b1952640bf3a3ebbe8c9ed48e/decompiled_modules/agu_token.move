module 0xd82fbd2cfadc949fe9e07edcb1f8752be2d6067b1952640bf3a3ebbe8c9ed48e::agu_token {
    struct AGU_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGU_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<AGU_TOKEN>(arg0) + arg1 <= 1000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGU_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU_TOKEN>(arg0, 6, b"AGU", b"AGU Token", b"AGU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/agoras-tokens-agrs-logo.png?v=040")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGU_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGU_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


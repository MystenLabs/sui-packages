module 0xa90a6092d45b2d2e9484558e07bcf38378f94d900dcacf389a7a32ab9e63a364::agu_token {
    struct AGU_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGU_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<AGU_TOKEN>(arg0) + arg1 <= 1000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGU_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU_TOKEN>(arg0, 6, b"BCH", b"BCH", b"BCH Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/bitcoin-cash.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGU_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGU_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


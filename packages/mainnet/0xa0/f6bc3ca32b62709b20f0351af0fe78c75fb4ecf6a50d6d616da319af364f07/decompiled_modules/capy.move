module 0xa0f6bc3ca32b62709b20f0351af0fe78c75fb4ecf6a50d6d616da319af364f07::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"CAPY", b"Capybara", b"So chill, it's Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidr6e5hvb7cqybf4hnxcxmo3otp6yl7tq25ywakqasfskbshzanbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x2a1d7e33f921b2487c8469e27c8c93dacf05dcde2fb239b6deab3fca2af16a16::oasisdev {
    struct OASISDEV has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OASISDEV>, arg1: 0x2::coin::Coin<OASISDEV>) {
        0x2::coin::burn<OASISDEV>(arg0, arg1);
    }

    fun init(arg0: OASISDEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OASISDEV>(arg0, 6, b"Oasisdev", b"Oasisdev", b"Oasisdev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1847311651584049152/PDg9ymIp_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OASISDEV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OASISDEV>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OASISDEV>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OASISDEV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


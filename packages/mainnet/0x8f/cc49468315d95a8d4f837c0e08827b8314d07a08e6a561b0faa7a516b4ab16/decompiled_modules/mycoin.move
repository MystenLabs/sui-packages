module 0x8fcc49468315d95a8d4f837c0e08827b8314d07a08e6a561b0faa7a516b4ab16::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"MYCOIN", b"My Coin", x"e8bf99e698afe4b880e4b8aae7a4bae4be8be4bba3e5b881", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


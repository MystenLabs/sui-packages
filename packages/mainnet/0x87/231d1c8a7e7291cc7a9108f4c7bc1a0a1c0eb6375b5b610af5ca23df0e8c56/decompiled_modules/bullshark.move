module 0x87231d1c8a7e7291cc7a9108f4c7bc1a0a1c0eb6375b5b610af5ca23df0e8c56::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BULLSHARK>, arg1: 0x2::coin::Coin<BULLSHARK>) {
        0x2::coin::burn<BULLSHARK>(arg0, arg1);
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSHARK>(arg0, 6, b"BULLSHARK", b"Bull Shark SuiFrens", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/hWY2W5x/bullshark.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLSHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BULLSHARK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BULLSHARK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


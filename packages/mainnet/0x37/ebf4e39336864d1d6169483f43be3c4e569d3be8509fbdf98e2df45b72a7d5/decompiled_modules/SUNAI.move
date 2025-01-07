module 0x37ebf4e39336864d1d6169483f43be3c4e569d3be8509fbdf98e2df45b72a7d5::SUNAI {
    struct SUNAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUNAI>, arg1: 0x2::coin::Coin<SUNAI>) {
        0x2::coin::burn<SUNAI>(arg0, arg1);
    }

    fun init(arg0: SUNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNAI>(arg0, 9, b"SUNAI", b"SUNAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/BZwbNhg/sunai.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUNAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUNAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


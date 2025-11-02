module 0x1d33cb53a4994927c4e40c3c8bd2c870a0705b505e33601b05323962a3a6e0a6::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOL>, arg1: 0x2::coin::Coin<LOL>) {
        0x2::coin::burn<LOL>(arg0, arg1);
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"LOL", b"LOL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gocoin.one/uploads/logo_1762106042345_13b514a8.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


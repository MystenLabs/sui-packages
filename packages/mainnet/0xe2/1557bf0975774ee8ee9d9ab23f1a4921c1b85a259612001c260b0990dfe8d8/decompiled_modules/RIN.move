module 0xe21557bf0975774ee8ee9d9ab23f1a4921c1b85a259612001c260b0990dfe8d8::RIN {
    struct RIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RIN>, arg1: 0x2::coin::Coin<RIN>) {
        0x2::coin::burn<RIN>(arg0, arg1);
    }

    fun init(arg0: RIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIN>(arg0, 9, b"RSUI", b"Kagamine Rin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/MBY9b3q/rin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


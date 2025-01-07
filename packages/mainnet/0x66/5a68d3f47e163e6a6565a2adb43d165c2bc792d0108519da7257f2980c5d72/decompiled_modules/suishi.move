module 0x665a68d3f47e163e6a6565a2adb43d165c2bc792d0108519da7257f2980c5d72::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"Suishi", b"Sushi-shaped protector, safeguards the Sui blockchain with cryptographic power and a playful spirit. Forged from ancient culinary magic and cutting-edge code, Suishi ensures secure transactions and harmony in the decentralized seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2746_8e962e4528.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISHI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


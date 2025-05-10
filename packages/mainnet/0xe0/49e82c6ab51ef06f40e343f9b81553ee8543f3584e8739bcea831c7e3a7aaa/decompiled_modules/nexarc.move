module 0xe049e82c6ab51ef06f40e343f9b81553ee8543f3584e8739bcea831c7e3a7aaa::nexarc {
    struct NEXARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXARC>(arg0, 9, b"NEXARC", b"Nexa Reward Coin", b"The on-chain proof of reward for trading on the Nexa suite of trading products", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://nexa.xyz/nexa-reward-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEXARC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXARC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


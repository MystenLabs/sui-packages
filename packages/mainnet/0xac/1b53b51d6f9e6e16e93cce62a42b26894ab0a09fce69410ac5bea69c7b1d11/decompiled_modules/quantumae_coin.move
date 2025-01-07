module 0xac1b53b51d6f9e6e16e93cce62a42b26894ab0a09fce69410ac5bea69c7b1d11::quantumae_coin {
    struct QUANTUMAE_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QUANTUMAE_COIN>, arg1: 0x2::coin::Coin<QUANTUMAE_COIN>) {
        0x2::coin::burn<QUANTUMAE_COIN>(arg0, arg1);
    }

    fun init(arg0: QUANTUMAE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTUMAE_COIN>(arg0, 9, b"QUANTUMAE", b"QUANTUMAE_COIN", b"Quantumae Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://github.com/Quantumae/all/blob/main/my_coin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANTUMAE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTUMAE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QUANTUMAE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QUANTUMAE_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


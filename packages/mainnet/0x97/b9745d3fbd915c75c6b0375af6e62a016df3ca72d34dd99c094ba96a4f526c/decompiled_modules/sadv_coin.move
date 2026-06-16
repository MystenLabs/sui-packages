module 0x97b9745d3fbd915c75c6b0375af6e62a016df3ca72d34dd99c094ba96a4f526c::sadv_coin {
    struct SADV_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SADV_COIN>, arg1: 0x2::coin::Coin<SADV_COIN>) {
        0x2::coin::burn<SADV_COIN>(arg0, arg1);
    }

    fun init(arg0: SADV_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADV_COIN>(arg0, 9, b"SADV", b"VASDOS", b"VASDOS TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/benjabbbb/default/refs/heads/main/28b17219.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADV_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADV_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SADV_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SADV_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}


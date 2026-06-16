module 0xd5b6613e435f691e7f89bccd47b452fae3b41ffb96fd6d72f57c9ab71ad34d22::sri7_l_coin {
    struct SRI7_L_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SRI7_L_COIN>, arg1: 0x2::coin::Coin<SRI7_L_COIN>) {
        0x2::coin::burn<SRI7_L_COIN>(arg0, arg1);
    }

    fun init(arg0: SRI7_L_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRI7_L_COIN>(arg0, 9, b"SRI7_L", b"SRI7.", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/benjabbbb/default/refs/heads/main/28b17219.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRI7_L_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRI7_L_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SRI7_L_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SRI7_L_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}


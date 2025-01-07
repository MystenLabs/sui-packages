module 0xc7adb646cb41cfe09237bd656d2f4a2b239c1dfa3164fe6cc0bd9eeb3a3eccd1::SF {
    struct SF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SF>, arg1: 0x2::coin::Coin<SF>) {
        0x2::coin::burn<SF>(arg0, arg1);
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<SF>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 9, b"SF", b"SUIFARM Token", b"Native token of suifarm.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suifarm.xyz/images/sf.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<SF>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SF>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}


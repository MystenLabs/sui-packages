module 0x17aa08f34dd6a0c8a00dfec416e98340809965e5573afee6c091bdc8a277c7bb::habibi {
    struct HABIBI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HABIBI>, arg1: 0x2::coin::Coin<HABIBI>) {
        0x2::coin::burn<HABIBI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HABIBI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HABIBI>>(0x2::coin::mint<HABIBI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HABIBI>(arg0, 9, b"HABIBI", b"HABIBI", b"HABIBI is the token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HABIBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIBI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


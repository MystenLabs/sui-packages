module 0x5c02db29fe42aa7d9ff7cd3a2bf3792a4eb12cf2185679db84931439cf593bfd::shezuka {
    struct SHEZUKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHEZUKA>, arg1: 0x2::coin::Coin<SHEZUKA>) {
        0x2::coin::burn<SHEZUKA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHEZUKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHEZUKA>>(0x2::coin::mint<SHEZUKA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHEZUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEZUKA>(arg0, 9, b"Shezuka", b"SHEZUKA", b"test token by defibitch", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEZUKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEZUKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


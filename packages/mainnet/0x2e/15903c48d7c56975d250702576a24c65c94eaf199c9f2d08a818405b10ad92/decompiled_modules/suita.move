module 0x2e15903c48d7c56975d250702576a24c65c94eaf199c9f2d08a818405b10ad92::suita {
    struct SUITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITA>(arg0, 6, b"SUITA", b"SUITA", b"https://i.imgur.com/1yVkEUQ.jpeg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


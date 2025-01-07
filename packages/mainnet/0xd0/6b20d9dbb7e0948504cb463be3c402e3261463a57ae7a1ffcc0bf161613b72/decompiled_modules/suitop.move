module 0xd06b20d9dbb7e0948504cb463be3c402e3261463a57ae7a1ffcc0bf161613b72::suitop {
    struct SUITOP has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITOP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITOP>>(0x2::coin::mint<SUITOP>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUITOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOP>(arg0, 9, b"SUITOP", b"SUITOP", b"SUITOP is 5 buck meme coin just by hitting ath", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


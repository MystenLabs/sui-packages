module 0xdf2022bdf94b01ac2333f618fa58b3bf6ccb69c190aa34737cfc5dd5bd99cac::BUTTON {
    struct BUTTON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUTTON>, arg1: 0x2::coin::Coin<BUTTON>) {
        0x2::coin::burn<BUTTON>(arg0, arg1);
    }

    fun init(arg0: BUTTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTON>(arg0, 9, b"BUTTON", b"BUTTON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUTTON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUTTON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BUTTON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


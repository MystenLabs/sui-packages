module 0xadf93a073d8ad7068f7da64cd65000062a6967af47c9b0582b6b160ec265d467::ttkn {
    struct TTKN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TTKN>, arg1: 0x2::coin::Coin<TTKN>) {
        0x2::coin::burn<TTKN>(arg0, arg1);
    }

    fun init(arg0: TTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTKN>(arg0, 9, b"TTKN", b"Test Token", b"My test token with proper configuration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/uJMPOdY.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTKN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTKN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTKN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTKN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


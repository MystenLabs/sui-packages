module 0xbc2bf0fa56c6a96f55cb985af1bfaf28ac31056a3fa7c07079b1fad39b1147e6::SUINU {
    struct SUINU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINU>, arg1: 0x2::coin::Coin<SUINU>) {
        0x2::coin::burn<SUINU>(arg0, arg1);
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 2, b"SUINU", b"Sui Inu", b"First inu on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ck86OLZ.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


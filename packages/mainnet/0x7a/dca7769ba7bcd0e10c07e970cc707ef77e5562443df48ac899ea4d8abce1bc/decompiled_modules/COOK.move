module 0x7adca7769ba7bcd0e10c07e970cc707ef77e5562443df48ac899ea4d8abce1bc::COOK {
    struct COOK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<COOK>, arg1: 0x2::coin::Coin<COOK>) {
        0x2::coin::burn<COOK>(arg0, arg1);
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 9, b"COOK", b"Suicook", b"Become a part of our team and cook up an abundance of delights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/0rikqya.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COOK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


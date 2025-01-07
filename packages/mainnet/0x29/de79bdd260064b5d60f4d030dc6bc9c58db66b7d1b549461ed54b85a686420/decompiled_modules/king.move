module 0x29de79bdd260064b5d60f4d030dc6bc9c58db66b7d1b549461ed54b85a686420::king {
    struct KING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KING>, arg1: 0x2::coin::Coin<KING>) {
        0x2::coin::burn<KING>(arg0, arg1);
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 5, b"KING", b"KING", b"New Market King for Meme with only 21M supply", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.vecteezy.com/system/resources/thumbnails/016/126/416/small_2x/king-crown-esport-logo-design-vector.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<KING>(arg0) + arg1 <= 2100000000000, 1);
        0x2::coin::mint_and_transfer<KING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0xd2eb120c108e9bf53cd19cfc988c673bc1b998413262821ac547e6ce5ae33332::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGESUI>, arg1: 0x2::coin::Coin<DOGESUI>) {
        0x2::coin::burn<DOGESUI>(arg0, arg1);
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 9, b"doge sui", b"Doge", b"The Second best meme token that Sui has ever seen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/4dQcF0E.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
        0x2::coin::mint_and_transfer<DOGESUI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGESUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGESUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


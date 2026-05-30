module 0x58a31e55ec0b7e8c4671fbfe7c14be71beed030ffdb0429924c4a29823955530::shibsui {
    struct SHIBSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBSUI>, arg1: 0x2::coin::Coin<SHIBSUI>) {
        0x2::coin::burn<SHIBSUI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIBSUI>>(0x2::coin::mint<SHIBSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBSUI>(arg0, 9, b"SSHIB", b"SHIBSUI", b"SHIBSUI meme coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


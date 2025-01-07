module 0xa0336af4144ad5ecf79d47b27bbc240632c4e91cb501e0c62f641685db23506c::imada {
    struct IMADA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IMADA>, arg1: 0x2::coin::Coin<IMADA>) {
        0x2::coin::burn<IMADA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IMADA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IMADA>>(0x2::coin::mint<IMADA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IMADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMADA>(arg0, 9, b"imada", b"IMADA", b"Imad test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMADA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMADA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


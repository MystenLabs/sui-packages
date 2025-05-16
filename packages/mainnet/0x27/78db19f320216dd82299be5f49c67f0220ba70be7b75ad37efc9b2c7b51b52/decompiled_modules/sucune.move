module 0x2778db19f320216dd82299be5f49c67f0220ba70be7b75ad37efc9b2c7b51b52::sucune {
    struct SUCUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCUNE>(arg0, 6, b"SUCUNE", b"SUICUNE", b"$SUICUNE is one of the legendary beast Pokemon. A water type also known as Aurora Pokemon that will shine in $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihpi4t5zewv54ktgntwrt652auqpwfi6x75hogeaksectibg4h6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUCUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


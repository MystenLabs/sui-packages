module 0x5211243f4e1bc48f562b912b3d36ec2a701bd8e2c61631cd45257b4aaface1e::colon {
    struct COLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLON>(arg0, 9, b"colon", b"official fart reserve", b"The official fart reserve: The Colon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUW91MjPqXXz8WZMZRHH833UqSCKtqwHFMx9nxuEZaEiW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COLON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


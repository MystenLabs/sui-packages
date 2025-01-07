module 0x7694a30caeae563476102f54db69ff52ec9c38be34b0c1a4ab0dbafaa2ef4771::piggy {
    struct PIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGY>(arg0, 6, b"PIGGY", b"Hamlet the pig on Sui", b"THE $PIGGY MEMECOIN ON SUI: piggyhamletcoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x350006a2c99e945498bc4b9f0eeafd6ce9a894ac_fdd433ba7f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}


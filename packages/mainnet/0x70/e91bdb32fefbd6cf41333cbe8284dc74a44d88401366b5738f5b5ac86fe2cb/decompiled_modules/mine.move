module 0x70e91bdb32fefbd6cf41333cbe8284dc74a44d88401366b5738f5b5ac86fe2cb::mine {
    struct MINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINE>(arg0, 6, b"MINE", b"Mine Da Seagull", b" Seagulls Mine is not an ordinary bird memecoin. With its roots in the Pixar classic, this token brings a touch of nostalgia and humor to the crypto space. My mission is to spread joy, laughter and a pinch of maritime evil through the  Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dodo_azul_91def7c81d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINE>>(v1);
    }

    // decompiled from Move bytecode v6
}


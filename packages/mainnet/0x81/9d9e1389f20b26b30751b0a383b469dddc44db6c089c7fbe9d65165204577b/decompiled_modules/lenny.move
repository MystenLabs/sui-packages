module 0x819d9e1389f20b26b30751b0a383b469dddc44db6c089c7fbe9d65165204577b::lenny {
    struct LENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENNY>(arg0, 6, b"LENNY", b"Lenny Moon", b"One day, mankind will look back and say it all started with a clap-dancing dog. Do not be late to history, for it is your future. $LENNY There's a new dog in town!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2345345_c38cd7e9f1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}


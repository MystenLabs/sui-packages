module 0xa13a68ffbdd07ebd81e276308692e4fa8404cfe3c6264e8edeb3f2eab8dba4be::suiplup {
    struct SUIPLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLUP>(arg0, 6, b"SUIPLUP", b"Sui Plup", b"Plup is flying", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028543_9a17ecb563.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


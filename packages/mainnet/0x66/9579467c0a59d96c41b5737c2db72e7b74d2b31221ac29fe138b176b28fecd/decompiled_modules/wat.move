module 0x669579467c0a59d96c41b5737c2db72e7b74d2b31221ac29fe138b176b28fecd::wat {
    struct WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAT>(arg0, 6, b"WAT", b"WAT ON SUI", b"Wat x  Matt Furie's pet rat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ratt_logo_1536x1536_7bb6e0e4a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


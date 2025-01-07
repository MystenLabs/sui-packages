module 0x2bd5760e74d7011e7c643320424df4e9ee1d623dfe66cf4d58e16959f1d11077::suio {
    struct SUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIO>(arg0, 6, b"SUIO", b"SuiOptimus", b"I'm SuiOptimus! I'm the leader of the SUI Community! I aim to lead the #SUI community to greatness. Our mission? To get $SUI to $10! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1b93546b53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIO>>(v1);
    }

    // decompiled from Move bytecode v6
}


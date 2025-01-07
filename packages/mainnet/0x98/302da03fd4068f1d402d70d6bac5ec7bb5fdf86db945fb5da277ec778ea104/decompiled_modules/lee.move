module 0x98302da03fd4068f1d402d70d6bac5ec7bb5fdf86db945fb5da277ec778ea104::lee {
    struct LEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LEE>(arg0, 6, b"LEE", b"test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/wp2481032_bruce_lee_quotes_wallpapers_e0cada4ebf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


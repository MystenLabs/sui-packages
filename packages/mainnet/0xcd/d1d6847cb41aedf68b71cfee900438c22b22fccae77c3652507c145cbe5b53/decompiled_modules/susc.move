module 0xcdd1d6847cb41aedf68b71cfee900438c22b22fccae77c3652507c145cbe5b53::susc {
    struct SUSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSC>(arg0, 6, b"SUSC", b"Suspect Cat", b"Catnip made me do it. I swear!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71c3646ae8158efa14ff5315a9995125_97eea6c245.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSC>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x226c5512c757b949996cf815ad7303e7c350f99f0fb016ccd8a53d99a5c5c4fa::clumsysmurf {
    struct CLUMSYSMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUMSYSMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUMSYSMURF>(arg0, 6, b"Clumsysmurf", b"smorfi", b"smorfi is a memecoin in sui world .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_f2c9ee9945.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUMSYSMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUMSYSMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}


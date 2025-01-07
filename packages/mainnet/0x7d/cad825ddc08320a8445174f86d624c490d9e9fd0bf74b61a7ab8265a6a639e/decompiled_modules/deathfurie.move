module 0x7dcad825ddc08320a8445174f86d624c490d9e9fd0bf74b61a7ab8265a6a639e::deathfurie {
    struct DEATHFURIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEATHFURIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEATHFURIE>(arg0, 6, b"DEATHFURIE", b"Death Furie", b"Death Furie, one of Matt Furie's best works has arrived on Sui to eliminate all other furies from the ecosystem. Join Us on TG.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_1_5d260ba092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEATHFURIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEATHFURIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


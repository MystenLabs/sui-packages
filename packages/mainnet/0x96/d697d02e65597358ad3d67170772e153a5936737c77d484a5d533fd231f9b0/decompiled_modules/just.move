module 0x96d697d02e65597358ad3d67170772e153a5936737c77d484a5d533fd231f9b0::just {
    struct JUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<JUST>(arg0, 6, b"JUST", b"just a guy", b"just an average everyday normal guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dq9i_NL_a18d2f065d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


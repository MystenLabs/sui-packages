module 0xe4d618ba6f601c5fa03ef03df29bdafa4fa94c2cf982195abb69f73a20ee622f::slurp {
    struct SLURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLURP>(arg0, 9, b"SLURP", b"Hydro Homies", b"MY HOMIES SLURP ALL DAY N NIGHT 2 STAY HYDRATED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/xgGMvGv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLURP>(&mut v2, 6942000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLURP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLURP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x55d3107f334634821b8f8c187648d68169f3d8bcfcd756fc2e71f2295ffc533::suifartcoin {
    struct SUIFARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFARTCOIN>(arg0, 6, b"SUIFARTCOIN", b"FARTCOIN ON SUI", b"FARTCOIN IS NOW ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003652_cc996729c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFARTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFARTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


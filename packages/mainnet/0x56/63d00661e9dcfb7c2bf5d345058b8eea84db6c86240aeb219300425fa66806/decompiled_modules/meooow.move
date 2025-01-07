module 0x5663d00661e9dcfb7c2bf5d345058b8eea84db6c86240aeb219300425fa66806::meooow {
    struct MEOOOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOOOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOOOW>(arg0, 6, b"Meooow", b"Meowpump", b"Movepump's cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GWB_Ua_B0_Wc_A_Ar_F_p_024b012933.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOOOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOOOW>>(v1);
    }

    // decompiled from Move bytecode v6
}


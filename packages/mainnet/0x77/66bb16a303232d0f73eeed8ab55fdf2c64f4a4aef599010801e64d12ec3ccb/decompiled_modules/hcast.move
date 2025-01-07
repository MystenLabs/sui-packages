module 0x7766bb16a303232d0f73eeed8ab55fdf2c64f4a4aef599010801e64d12ec3ccb::hcast {
    struct HCAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAST>(arg0, 6, b"HCAST", b"Honey Cast", x"4e6170207768656e2068652066696e616c6c7920676f7420686973200a40737465616479746564647973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg_Gjy_Zao_A_Ah1_D7_faf3637f69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCAST>>(v1);
    }

    // decompiled from Move bytecode v6
}


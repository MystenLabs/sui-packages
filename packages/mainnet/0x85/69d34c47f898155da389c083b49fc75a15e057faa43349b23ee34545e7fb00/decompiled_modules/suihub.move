module 0x8569d34c47f898155da389c083b49fc75a15e057faa43349b23ee34545e7fb00::suihub {
    struct SUIHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUB>(arg0, 6, b"SUIHUB", b"Sui Hub", b"Sui Hub platform will be live next week full of rewards for all holders and platform users. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_A58998_B_6258_4_A75_BA_91_FD_460550_D54_A_4ecc36348d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}


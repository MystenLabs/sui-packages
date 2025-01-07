module 0x224f3917291465187615887efb23de597f104324494b79787dd9fbdd1e6f477d::wetawio {
    struct WETAWIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETAWIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETAWIO>(arg0, 6, b"WETAWIO", b"Wetawio Meme", b"wetawio is memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Gu8nnk_Nuws63_Eu_Dw_U9_Pkfzx8_L4a6ec_Q_Wamwsr_D7w_V4y_3d72241810.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETAWIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETAWIO>>(v1);
    }

    // decompiled from Move bytecode v6
}


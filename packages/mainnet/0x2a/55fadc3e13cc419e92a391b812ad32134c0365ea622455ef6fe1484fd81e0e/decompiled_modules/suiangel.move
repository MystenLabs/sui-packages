module 0x2a55fadc3e13cc419e92a391b812ad32134c0365ea622455ef6fe1484fd81e0e::suiangel {
    struct SUIANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANGEL>(arg0, 6, b"SuiAngel", b"SUIA", b"The mascots built in the Sui ecosystem make every Builder involved in the ecosystem feel happy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5e17f03cd65321cd599098f403ada87c_720w_f945d55a10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANGEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANGEL>>(v1);
    }

    // decompiled from Move bytecode v6
}


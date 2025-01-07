module 0x7f188dbdd89a092e0de2ab4e70a2d9b4ab131632c490f2c12b377a1bd40f0839::magas {
    struct MAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAS>(arg0, 6, b"MAGAS", b"MAGA SNAKES", b"The serpentine path to the white house", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_GN_Nc_C4_N_400x400_99f0468ff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}


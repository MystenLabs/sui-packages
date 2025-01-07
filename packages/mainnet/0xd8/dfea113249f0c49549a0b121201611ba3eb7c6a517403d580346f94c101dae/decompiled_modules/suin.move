module 0xd8dfea113249f0c49549a0b121201611ba3eb7c6a517403d580346f94c101dae::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"SUIniverse", b"Memes world in the SUI-inverse ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b6722ba7_fb99_4e3b_8c42_ae5bb04043ec_6be3caa357.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


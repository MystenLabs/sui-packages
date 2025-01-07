module 0x4bc9e0887d89cbb340cba470ca1e85e5fe0c64d932025d6aba2882cc47ffaa2e::unicoinsui {
    struct UNICOINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICOINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICOINSUI>(arg0, 6, b"UNICOINSUI", b"UNI SUI COIN", x"24554e492c2053756920666f756e646572200a404576616e77656233277320646f67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_13_233048417_92db3c9e98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICOINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICOINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


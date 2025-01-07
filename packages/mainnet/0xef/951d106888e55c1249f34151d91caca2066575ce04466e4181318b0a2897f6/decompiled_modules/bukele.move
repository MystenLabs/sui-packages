module 0xef951d106888e55c1249f34151d91caca2066575ce04466e4181318b0a2897f6::bukele {
    struct BUKELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKELE>(arg0, 6, b"BUKELE", b"BUKELE TRUE HEROE", b"THE FIRST MEME IN THE WORLD by BUKELE. tribute to a true HERO. Nayib Bukele is the first president of a nation in the history of humanity to legalize BTC as a legal currency of circulation in a country in the world. Bukele changed the history of humanity and opened the doors for BTC to become the next largest and most important store of value on the planet. BUKELE true hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_21_11_2024_12144_diariodecuba_com_e8068aceac.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUKELE>>(v1);
    }

    // decompiled from Move bytecode v6
}


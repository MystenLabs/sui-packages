module 0x74f3f8d6c6263c6f0bc286d69a35704b829ba1f1d69ff086fa9183788be5f49::tigra {
    struct TIGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGRA>(arg0, 6, b"TIGRA", b"TIGRAONSUI", b"M!M!M!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3p_v2_Vl_P_400x400_f64388cf39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}


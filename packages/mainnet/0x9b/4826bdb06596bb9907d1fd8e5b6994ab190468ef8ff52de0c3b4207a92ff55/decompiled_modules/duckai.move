module 0x9b4826bdb06596bb9907d1fd8e5b6994ab190468ef8ff52de0c3b4207a92ff55::duckai {
    struct DUCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKAI>(arg0, 6, b"DUCKAI", b"DuckAi", b"DuckAi the biggest memecoin soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030089_7e54bd824e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


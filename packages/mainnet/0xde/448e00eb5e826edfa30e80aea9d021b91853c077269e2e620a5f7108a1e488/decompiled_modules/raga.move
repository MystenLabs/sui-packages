module 0xde448e00eb5e826edfa30e80aea9d021b91853c077269e2e620a5f7108a1e488::raga {
    struct RAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGA>(arg0, 6, b"RAGA", b"Remake America Great Again", b"ReMake America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fotor_ai_2024110116057_de262505c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}


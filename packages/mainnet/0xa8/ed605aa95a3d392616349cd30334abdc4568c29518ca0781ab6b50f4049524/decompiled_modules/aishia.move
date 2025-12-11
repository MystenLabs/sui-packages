module 0xa8ed605aa95a3d392616349cd30334abdc4568c29518ca0781ab6b50f4049524::aishia {
    struct AISHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISHIA>(arg0, 6, b"Aishia", b"aishiaanime", b"aishiaanime is a chatbot based similar to chatgpt, Gemini etc.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewwsnjrm4yl5hrhwxrxzdhjtotc2cfl7s6oiugsbgtjh6lgj25xa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISHIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISHIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


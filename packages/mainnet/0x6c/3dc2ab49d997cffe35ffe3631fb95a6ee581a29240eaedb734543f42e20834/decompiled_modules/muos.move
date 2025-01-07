module 0x6c3dc2ab49d997cffe35ffe3631fb95a6ee581a29240eaedb734543f42e20834::muos {
    struct MUOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUOS>(arg0, 6, b"MUOS", b"Memes Underground on SUI", b"MEME TOKEN MUOS BUY AND SELL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_2778e1e598.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUOS>>(v1);
    }

    // decompiled from Move bytecode v6
}


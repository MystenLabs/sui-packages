module 0x1c230c96ae1a775b53cdd62a863681bda9da1a8ba8c89ad535662d15c2626f49::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 6, b"DONTBUY", b"Do not buy", b"Just for the snipe bots ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marble_texture_seamless_background_abstract_pattern_free_vector_0c3058357d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x3a542dda70b1567fedf17ae9c97418d1b36eac2f7e170b06e1c52561c27699d3::ecoin {
    struct ECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOIN>(arg0, 6, b"Ecoin", b"Einstein coin", b"\"I feel the infinite power!\" said Einstein.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_c_2_9fd6d064f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x443ba2be18417d56cdd66e9b4ca0590e3bec573bc80c1d251e1a18dfc995de3a::ggong {
    struct GGONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGONG>(arg0, 6, b"Ggong", b"Gonggong", b"Gonggong is a Chinese water god who is depicted in Chinese mythology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/safaff_8aa2080bf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGONG>>(v1);
    }

    // decompiled from Move bytecode v6
}


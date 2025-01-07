module 0x3eb3b0247d18d7d42203c532ec62711956196249a1f303af6dcb60a53461eaad::rapper {
    struct RAPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPPER>(arg0, 6, b"RAPPER", b"Frederico, el mapache rapero", b"Frederico is a twice platnium ghost writer for some of the biggest names in music today. Well finally he's tired of that and he's coming to the light with some heavy hitters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/726a151c4d72b8982b715d3c13729240_d57aedc9dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}


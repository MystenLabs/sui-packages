module 0xb6254bea1a0c73f774ec79efe6434216f83f8cef6796d3a31c181fcf5cd306cc::limo {
    struct LIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMO>(arg0, 6, b"LIMO", b"SuperLongLimoCoin", b"We got a Super Long Limo and we have a seat for anybody but jets! Full throttle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030451_c2a3e07126.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}


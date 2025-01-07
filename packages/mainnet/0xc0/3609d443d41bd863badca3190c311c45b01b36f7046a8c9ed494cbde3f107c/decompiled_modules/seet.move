module 0xc03609d443d41bd863badca3190c311c45b01b36f7046a8c9ed494cbde3f107c::seet {
    struct SEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEET>(arg0, 6, b"Seet", b"Suieet", b"Hello .btc Welcome to the Confectionery shop ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3064_019a15477e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEET>>(v1);
    }

    // decompiled from Move bytecode v6
}


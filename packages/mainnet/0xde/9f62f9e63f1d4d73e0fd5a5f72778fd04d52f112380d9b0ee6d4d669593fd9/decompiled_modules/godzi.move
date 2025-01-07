module 0xde9f62f9e63f1d4d73e0fd5a5f72778fd04d52f112380d9b0ee6d4d669593fd9::godzi {
    struct GODZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODZI>(arg0, 6, b"GODZI", b"GODZI TG MASCOT", b"Godzi the new Telegram Mascot is here! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gdz_fb5a83dc75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODZI>>(v1);
    }

    // decompiled from Move bytecode v6
}


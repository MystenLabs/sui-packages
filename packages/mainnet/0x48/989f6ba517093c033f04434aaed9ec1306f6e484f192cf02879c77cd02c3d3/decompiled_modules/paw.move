module 0x48989f6ba517093c033f04434aaed9ec1306f6e484f192cf02879c77cd02c3d3::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 6, b"PAW", b"PawPawSui", b"hop hop, grrr grr, woof woof !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_164509_92ea030660.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAW>>(v1);
    }

    // decompiled from Move bytecode v6
}


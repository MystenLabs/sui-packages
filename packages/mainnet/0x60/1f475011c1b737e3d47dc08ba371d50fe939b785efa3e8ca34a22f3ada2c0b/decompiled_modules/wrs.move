module 0x601f475011c1b737e3d47dc08ba371d50fe939b785efa3e8ca34a22f3ada2c0b::wrs {
    struct WRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRS>(arg0, 6, b"WRS", b"Wallrussell", b"No Discord | No Social | MEME Sui Only have FUN!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wallrus_bd774948fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRS>>(v1);
    }

    // decompiled from Move bytecode v6
}


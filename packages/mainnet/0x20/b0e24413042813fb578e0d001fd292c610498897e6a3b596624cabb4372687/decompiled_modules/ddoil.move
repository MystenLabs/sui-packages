module 0x20b0e24413042813fb578e0d001fd292c610498897e6a3b596624cabb4372687::ddoil {
    struct DDOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOIL>(arg0, 6, b"DDOIL", b"Diddy OIL", b"Funny meme on Diddy oil ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054939_2705691590.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}


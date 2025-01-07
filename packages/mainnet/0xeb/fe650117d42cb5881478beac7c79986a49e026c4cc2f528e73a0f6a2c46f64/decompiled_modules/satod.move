module 0xebfe650117d42cb5881478beac7c79986a49e026c4cc2f528e73a0f6a2c46f64::satod {
    struct SATOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOD>(arg0, 6, b"SATOD", b"Satoshiduck", b"SatoshiduckOn Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Satod_07313d1868.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOD>>(v1);
    }

    // decompiled from Move bytecode v6
}


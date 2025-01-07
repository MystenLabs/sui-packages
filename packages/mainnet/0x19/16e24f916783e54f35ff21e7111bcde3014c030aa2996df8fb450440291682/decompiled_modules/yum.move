module 0x1916e24f916783e54f35ff21e7111bcde3014c030aa2996df8fb450440291682::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"SuiSauce", x"49747320746861742059756d2059756d205361756365200a45766572796f6e65206c6f7665732059756d2059756d2053617563650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2186_3936419845.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUM>>(v1);
    }

    // decompiled from Move bytecode v6
}


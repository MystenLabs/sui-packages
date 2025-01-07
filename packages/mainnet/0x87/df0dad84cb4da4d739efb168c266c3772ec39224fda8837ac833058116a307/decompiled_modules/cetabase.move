module 0x87df0dad84cb4da4d739efb168c266c3772ec39224fda8837ac833058116a307::cetabase {
    struct CETABASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETABASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETABASE>(arg0, 6, b"Cetabase", b"Cetabase koharu", b"$Miharu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7503_6e9f39b2d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETABASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETABASE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x9804a1ddd2c98b198c0a1812364d67f09949168bdf05e557428ba3efeb0c70e4::ardu {
    struct ARDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARDU>(arg0, 0x83fa035d3d43c4da8af5c961cb604cd564e13b9622c306eb5127ae8fbf761ca7::constants::lp_decimals(), b"ARDU", b"Armand Duplantis", b"LP Coin type for the Duplantis Vault", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/7/73/Armand_Duplantis%28cropped%29_Budapest_2023.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARDU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x845bef51ca72dfca23f4888168b39450edaa2c24df94b574684bffa4e880e4a5::yn2016 {
    struct YN2016 has drop {
        dummy_field: bool,
    }

    fun init(arg0: YN2016, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YN2016>(arg0, 6, b"YN2016", b"Your Name (2016)", b"Your Name (2016) Anime Aesthetic Movie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731569359671.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YN2016>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YN2016>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


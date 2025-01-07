module 0xb1e2e963975ff931192fb2ed90b56e073b8322b90dd68c296ac3496408010339::riq {
    struct RIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RIQ>(arg0, 6, b"RIQ", b"RICO", x"4147454e5445205155452050524556c38a204e4f56412043524950544f4d4f45444120444520492e412e20434f4d2050524f42414c4944414445204445204558504c4f53c3834f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/alien_032bca9920.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIQ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIQ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


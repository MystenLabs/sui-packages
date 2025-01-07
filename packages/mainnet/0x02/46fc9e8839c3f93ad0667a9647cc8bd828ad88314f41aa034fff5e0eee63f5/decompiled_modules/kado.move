module 0x246fc9e8839c3f93ad0667a9647cc8bd828ad88314f41aa034fff5e0eee63f5::kado {
    struct KADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KADO>(arg0, 6, b"KADO", b"KADOKAWA", b"Maximize the Value of Content Through Live-Action and Anime. We plan, produce and distribute live-action and animated works, license movie distributions rights, sell package software and also operate Mubichike, a ticketing system for viewing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734621650316.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KADO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KADO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


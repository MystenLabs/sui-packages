module 0x9dfcd2e32ea6997b3e81ec07a747bed9b0bfbb05cda293352c5532cfd41c2095::suku {
    struct SUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKU>(arg0, 6, b"SUKU", b"Suigonku", b"7 Dragon Community on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730445367092.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


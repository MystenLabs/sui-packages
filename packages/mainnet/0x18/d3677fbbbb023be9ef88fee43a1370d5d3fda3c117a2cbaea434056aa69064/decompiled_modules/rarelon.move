module 0x18d3677fbbbb023be9ef88fee43a1370d5d3fda3c117a2cbaea434056aa69064::rarelon {
    struct RARELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARELON>(arg0, 6, b"RARELON", b"RarElon", b"Rare Elon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732477330500.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RARELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


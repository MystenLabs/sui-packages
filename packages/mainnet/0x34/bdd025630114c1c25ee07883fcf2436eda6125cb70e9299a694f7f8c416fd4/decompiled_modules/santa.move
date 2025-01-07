module 0x34bdd025630114c1c25ee07883fcf2436eda6125cb70e9299a694f7f8c416fd4::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTA>(arg0, 6, b"SANTA", b"Santa", b"Santa Clause is coming to town... Merry Xmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734787253861.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


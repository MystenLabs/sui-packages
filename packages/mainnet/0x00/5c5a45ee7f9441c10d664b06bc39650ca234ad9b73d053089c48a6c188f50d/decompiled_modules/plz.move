module 0x5c5a45ee7f9441c10d664b06bc39650ca234ad9b73d053089c48a6c188f50d::plz {
    struct PLZ has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PLZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PLZ>>(0x2::coin::mint<PLZ>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: PLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLZ>(arg0, 9, b"PLZ", b"PLZ", b"$PLZ is for those who ask. https://plz.money | a @moral_capital protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https:/plz.money/coin-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLZ>>(v0, @0x9b64873f7e7b85b39886ed190040c31b345c9af4eb3ec95cb165222045815943);
    }

    // decompiled from Move bytecode v6
}


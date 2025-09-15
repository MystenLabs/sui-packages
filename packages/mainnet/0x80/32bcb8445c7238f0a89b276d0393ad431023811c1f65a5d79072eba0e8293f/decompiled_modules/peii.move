module 0x8032bcb8445c7238f0a89b276d0393ad431023811c1f65a5d79072eba0e8293f::peii {
    struct PEII has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEII>(arg0, 6, b"PEII", b"POMPEII", b"\"The eruption of Mount Vesuvius in 79 AD that buried the city of Pompeii under volcanic ash.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757945590500.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


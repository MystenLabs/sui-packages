module 0xef642803ca2fa848d914fe40dca13c682a47886eff90f762367ff050b1802c24::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"TEST", b"ATATATAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750639895522.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


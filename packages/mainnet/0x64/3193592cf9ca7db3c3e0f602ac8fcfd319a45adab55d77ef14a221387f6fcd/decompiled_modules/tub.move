module 0x643193592cf9ca7db3c3e0f602ac8fcfd319a45adab55d77ef14a221387f6fcd::tub {
    struct TUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUB>(arg0, 6, b"TUB", b"Cat In A Tub", b"Cat in a Tub enjoy the ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O7z_Jxyrp_Sl6bnw_Pg_Tq_Ogtw_e8e01002db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUB>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x65bdbacb981b80e073f2284421a666fe7c82d787aa1dd3a19f128dcaa796e396::shawk {
    struct SHAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWK>(arg0, 6, b"SHAWK", b"SUI SHAWK", b"$SHAWK nimbly crosses its waters, lured by the aromatic scent of the bloody market, it quickly shoots towards its prey and eats all red dips coming across him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plague_574f9bf723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}


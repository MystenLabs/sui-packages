module 0x235b9ba15104f3439e72fa63b09be1efebd9367c8f32aa382a7d08f9e9a36230::suicait {
    struct SUICAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAIT>(arg0, 6, b"Suicait", b"$SUICAIT", b"The cutest cat on the newest Chain SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000108091_1d1bf98524.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAIT>>(v1);
    }

    // decompiled from Move bytecode v6
}


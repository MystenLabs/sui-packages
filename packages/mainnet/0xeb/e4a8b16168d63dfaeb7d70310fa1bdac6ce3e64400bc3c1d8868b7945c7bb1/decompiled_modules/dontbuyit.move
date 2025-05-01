module 0xebe4a8b16168d63dfaeb7d70310fa1bdac6ce3e64400bc3c1d8868b7945c7bb1::dontbuyit {
    struct DONTBUYIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUYIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUYIT>(arg0, 6, b"Dontbuyit", b"Do Not Buy PLS!!!", b"If u buy u wont suin ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_7692fe494c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUYIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUYIT>>(v1);
    }

    // decompiled from Move bytecode v6
}


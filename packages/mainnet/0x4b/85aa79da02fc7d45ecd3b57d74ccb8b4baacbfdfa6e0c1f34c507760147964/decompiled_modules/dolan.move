module 0x4b85aa79da02fc7d45ecd3b57d74ccb8b4baacbfdfa6e0c1f34c507760147964::dolan {
    struct DOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLAN>(arg0, 6, b"DOLAN", b"Dolan the Sui Duck", b"Look at mi, Dolan iz de sui cptain now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x381ab19e04bd9dc333794a9f4d343daeee3b7069_85c92d488e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


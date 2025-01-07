module 0x648eec06d2464b4c03947ad8bd0310b90518a91bb96f07eb5b3c8b47c940a5b9::cater {
    struct CATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATER>(arg0, 6, b"CATER", b"Cat in water", b"Not today, aquatic adventures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_165933_63a268d80b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATER>>(v1);
    }

    // decompiled from Move bytecode v6
}


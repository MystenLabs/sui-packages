module 0xbf1de6dc84886ac8634c2f1df0f85086ace332e54e57f3c069a842bd04c71fb5::yen {
    struct YEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEN>(arg0, 6, b"Yen", b"Yen go up", b"The meaning of  is that the chart is in an uptrend, and the Japanese symbol is associated with up, up, and higher.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chart_increasing_with_yen_1f4b9_d1e4e20fb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


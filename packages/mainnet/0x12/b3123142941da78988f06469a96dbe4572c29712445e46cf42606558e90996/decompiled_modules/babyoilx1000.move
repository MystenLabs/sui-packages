module 0x12b3123142941da78988f06469a96dbe4572c29712445e46cf42606558e90996::babyoilx1000 {
    struct BABYOILX1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYOILX1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYOILX1000>(arg0, 6, b"Babyoilx1000", b"babyoil", b"why diddy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_14_42_59_81315a4498.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYOILX1000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYOILX1000>>(v1);
    }

    // decompiled from Move bytecode v6
}


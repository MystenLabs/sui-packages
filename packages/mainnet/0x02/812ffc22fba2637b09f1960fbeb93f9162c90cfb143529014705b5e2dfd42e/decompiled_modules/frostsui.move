module 0x2812ffc22fba2637b09f1960fbeb93f9162c90cfb143529014705b5e2dfd42e::frostsui {
    struct FROSTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTSUI>(arg0, 6, b"FrostSui", b"FrostSui the Snowman", b"Lets have fun while waiting for Santa. If you want to be Merry, join the fun and see you on Christmas Eve! Happy Holidays Sui traders!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033803_e63efbdf50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


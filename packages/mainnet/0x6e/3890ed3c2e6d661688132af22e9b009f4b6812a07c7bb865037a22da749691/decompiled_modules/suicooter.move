module 0x6e3890ed3c2e6d661688132af22e9b009f4b6812a07c7bb865037a22da749691::suicooter {
    struct SUICOOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOOTER>(arg0, 6, b"SUICOOTER", b"SuiCooter", b"Cats on scooters, riding to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicooter_92eb19d795.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOOTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}


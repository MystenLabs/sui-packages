module 0xa4aa45b32e5801c10642a73ec18b2e90a0c1fd4b2421b16b2583dbee5b150819::suicooter {
    struct SUICOOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOOTER>(arg0, 6, b"SUICOOTER", b"SuiCooter", b"Cats on scooters, riding to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicooter_b270e74ff7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOOTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}


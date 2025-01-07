module 0x909d1f92e3902549bc2d01cedbb7f61ed392f9d0a907e0212ed4f2997cc8070::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 6, b"SP", b"Suit Potaptos", b"HIGH ON carotene, vitamins E and C, iron, potassium and vitamin B6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/what_are_japanese_sweet_potatoes_5213007_efcadea6f02546f2bd240153d5ea058f_3063e5cb6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP>>(v1);
    }

    // decompiled from Move bytecode v6
}


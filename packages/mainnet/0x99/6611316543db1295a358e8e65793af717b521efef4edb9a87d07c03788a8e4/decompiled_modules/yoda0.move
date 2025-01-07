module 0x996611316543db1295a358e8e65793af717b521efef4edb9a87d07c03788a8e4::yoda0 {
    struct YODA0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA0>(arg0, 6, b"YODA0", b"YodaCoin0", b"yoda0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yoda_avarta_66a3ec58c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA0>>(v1);
    }

    // decompiled from Move bytecode v6
}


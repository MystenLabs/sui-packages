module 0xb96f7caf7b817dbf3615c5a6da05c0cf26eebec72fac09ca636e67c71435be04::limon {
    struct LIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMON>(arg0, 6, b"LIMON", b"Limon Sui Cat", b"Born of the mother of dragon s in year of bitcoin. Limon ready to conquer this world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020416_a38b187a61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}


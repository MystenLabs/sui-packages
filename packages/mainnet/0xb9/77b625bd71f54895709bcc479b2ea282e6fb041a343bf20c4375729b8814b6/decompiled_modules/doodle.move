module 0xb977b625bd71f54895709bcc479b2ea282e6fb041a343bf20c4375729b8814b6::doodle {
    struct DOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODLE>(arg0, 6, b"DOODLE", b"1-800-DOODLE", b"A commentary ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0228_634c3fb0fa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODLE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x428ab166d369eaa6a5ba3f9f34001b137548f97c8dba305bd99e193a03e3c149::weird {
    struct WEIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRD>(arg0, 6, b"WEIRD", b"WEIRDO", b"WEIRDOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_21_21_56_a8f053053a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}


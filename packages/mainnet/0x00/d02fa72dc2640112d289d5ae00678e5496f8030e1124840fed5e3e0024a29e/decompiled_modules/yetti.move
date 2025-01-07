module 0xd02fa72dc2640112d289d5ae00678e5496f8030e1124840fed5e3e0024a29e::yetti {
    struct YETTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETTI>(arg0, 6, b"YETTI", b"YETTI SUI", x"496e206120776f726c6420636f766572656420696e20736e6f772c2077686572652053616e746120436c61757320776173206d616b696e6720676966747320666f720a6368696c6472656e2c2061206d7973746572696f7573206372656174757265206c697665642e20497473206e616d65207761732059455454492c2061206c617267652c0a6675727279206769616e74206b6e6f776e206173207468650a27537069726974206f6620746865204d6f756e7461696e732e27", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6546_1b4e70323e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETTI>>(v1);
    }

    // decompiled from Move bytecode v6
}


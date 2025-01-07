module 0x103d3119e078e4cc574ad99c3b8ddac3e08d8e8bef53c457f867d9360650b7a4::suirush {
    struct SUIRUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUSH>(arg0, 6, b"SUIRUSH", b"SUI RUSH", b"SUIRUSH the day when we all see ruthless demons who will prey on cheating players!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044112_37ef3a4681.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}


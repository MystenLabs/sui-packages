module 0xeb58991d6373ac939c40fac983e6843494979712038e8e5cd3102fd7140d7e88::taylor {
    struct TAYLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAYLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAYLOR>(arg0, 6, b"TAYLOR", b"TAYLOR SUIFT", b"Taylor on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suift_9470fc837d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAYLOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAYLOR>>(v1);
    }

    // decompiled from Move bytecode v6
}


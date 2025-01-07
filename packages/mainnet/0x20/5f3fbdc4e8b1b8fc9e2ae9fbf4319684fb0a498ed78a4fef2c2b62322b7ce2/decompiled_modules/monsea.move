module 0x205f3fbdc4e8b1b8fc9e2ae9fbf4319684fb0a498ed78a4fef2c2b62322b7ce2::monsea {
    struct MONSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSEA>(arg0, 6, b"MONSEA", b"Monkey in the sea", b"i will try to the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_154752_8f5568f21d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSEA>>(v1);
    }

    // decompiled from Move bytecode v6
}


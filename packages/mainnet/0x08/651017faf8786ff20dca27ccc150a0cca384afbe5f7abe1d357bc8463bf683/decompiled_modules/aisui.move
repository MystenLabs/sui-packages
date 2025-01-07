module 0x8651017faf8786ff20dca27ccc150a0cca384afbe5f7abe1d357bc8463bf683::aisui {
    struct AISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUI>(arg0, 6, b"Aisui", b"Ai sui", b"Ai suii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906423_091365ef86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


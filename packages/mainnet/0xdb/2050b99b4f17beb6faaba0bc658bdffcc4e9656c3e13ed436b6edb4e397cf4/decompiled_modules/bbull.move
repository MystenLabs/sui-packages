module 0xdb2050b99b4f17beb6faaba0bc658bdffcc4e9656c3e13ed436b6edb4e397cf4::bbull {
    struct BBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBULL>(arg0, 6, b"BBULL", b"BLUE BULL", b"Meet Blue Bull, the unstoppable crypto force on the SUI Network. If youre ready to ride, then Blue Bull is your guy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_Logo_176affefd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}


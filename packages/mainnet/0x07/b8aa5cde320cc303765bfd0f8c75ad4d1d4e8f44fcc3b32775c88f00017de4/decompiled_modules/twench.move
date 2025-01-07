module 0x7b8aa5cde320cc303765bfd0f8c75ad4d1d4e8f44fcc3b32775c88f00017de4::twench {
    struct TWENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWENCH>(arg0, 6, b"TWENCH", b"Twench Sui", b"Twench is a token for the people who work hard every day to achieve financial success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_172736_d7c7f22a26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}


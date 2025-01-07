module 0xeb405ff27b7f875b31f39fc9c8505b627df0f75a93dcdc216d0f5f6b255dd2ee::googly {
    struct GOOGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGLY>(arg0, 6, b"Googly", b"Googly Cat", b"The cutest and coolest memecoin of the future $Googly cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f5df1473b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x43b7f671f431d5932667c96bfe90652246dc99d7d516bb10c46ac7c7f83ab422::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"TRUMP & CHOMP", b"TRUMP & CHOMP...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MC_3fff974dc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


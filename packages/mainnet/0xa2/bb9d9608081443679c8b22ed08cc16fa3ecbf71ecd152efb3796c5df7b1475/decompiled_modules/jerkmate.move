module 0xa2bb9d9608081443679c8b22ed08cc16fa3ecbf71ecd152efb3796c5df7b1475::jerkmate {
    struct JERKMATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERKMATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERKMATE>(arg0, 6, b"Jerkmate", b"Jerkmate Servers", b"How will this affect Jerkmate Servers? Join us at jerkmate!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jmattt_5fcf057206.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERKMATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JERKMATE>>(v1);
    }

    // decompiled from Move bytecode v6
}


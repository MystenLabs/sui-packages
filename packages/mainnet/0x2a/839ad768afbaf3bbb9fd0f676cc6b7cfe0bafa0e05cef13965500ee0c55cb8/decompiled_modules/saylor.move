module 0x2a839ad768afbaf3bbb9fd0f676cc6b7cfe0bafa0e05cef13965500ee0c55cb8::saylor {
    struct SAYLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYLOR>(arg0, 6, b"SAYLOR", b"SAYLOR MOON", b"$SAYLOR Token is a meme token created solely for entertainment purposes and has no real-world association with Michael Saylor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971540710.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAYLOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYLOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x3b46f1c3ab1c2512a3669038332d2501ebf83a8d2a5a82b5a3dfa1fd391e5705::bogs {
    struct BOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGS>(arg0, 6, b"BOGS", b"Sui Bogs", b"The bogs always needs something.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250429_232602_417_1b285bf638.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}


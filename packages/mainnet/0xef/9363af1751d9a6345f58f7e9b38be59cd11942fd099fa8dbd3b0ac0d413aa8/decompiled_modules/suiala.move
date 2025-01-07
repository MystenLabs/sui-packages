module 0xef9363af1751d9a6345f58f7e9b38be59cd11942fd099fa8dbd3b0ac0d413aa8::suiala {
    struct SUIALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALA>(arg0, 6, b"SUIALA", b"SUI KOALA", b"$SUIALA is a quiet, sleepy creature who spends most of its days lounging in eucalyptus trees. Its famous saying is \"Chillin' and Grillin' Gains,\" it encourages investors to take it easy while holding strong.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_96ba90416e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALA>>(v1);
    }

    // decompiled from Move bytecode v6
}


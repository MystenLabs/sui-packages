module 0xb4c84e38599a9639745dd8d449fbced3a2ed898f59f4657e90d0cabac1c59529::platy {
    struct PLATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATY>(arg0, 6, b"PLATY", b"Platypus", b"I'm a Platypus, not a Duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013689_871a614218.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLATY>>(v1);
    }

    // decompiled from Move bytecode v6
}


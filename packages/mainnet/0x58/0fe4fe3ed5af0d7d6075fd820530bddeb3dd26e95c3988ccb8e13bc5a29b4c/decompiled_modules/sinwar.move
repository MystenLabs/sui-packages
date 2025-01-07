module 0x580fe4fe3ed5af0d7d6075fd820530bddeb3dd26e95c3988ccb8e13bc5a29b4c::sinwar {
    struct SINWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINWAR>(arg0, 6, b"Sinwar", b"YAHYA SINWAR", b"Yahya sinwar ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027866_0e431a689e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


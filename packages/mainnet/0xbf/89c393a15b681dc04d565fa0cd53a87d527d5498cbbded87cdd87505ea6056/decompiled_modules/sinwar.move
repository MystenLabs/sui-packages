module 0xbf89c393a15b681dc04d565fa0cd53a87d527d5498cbbded87cdd87505ea6056::sinwar {
    struct SINWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINWAR>(arg0, 6, b"Sinwar", b"Yahya sinwar", b"A guy sitting on a chair ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027866_3a0f17c4c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINWAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINWAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


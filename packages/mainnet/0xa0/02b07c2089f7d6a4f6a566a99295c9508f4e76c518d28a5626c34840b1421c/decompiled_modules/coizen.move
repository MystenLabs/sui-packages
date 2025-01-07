module 0xa002b07c2089f7d6a4f6a566a99295c9508f4e76c518d28a5626c34840b1421c::coizen {
    struct COIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIZEN>(arg0, 6, b"COIZEN", b"Coizen Cat", b"Kick back, vibe out, and take your crypto game to the next level. No stress, just $COIZEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009735_e1902e5b54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


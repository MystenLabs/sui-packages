module 0x779e64624c447d1738350be27953095f2d383260297149aafbb60b0c86542b87::blink {
    struct BLINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINK>(arg0, 6, b"Blink", b"Blinking White Guy", b"Crazy memes and fun times ahead ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3533_9b6ca551d8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINK>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x4f2e9cbfb56680929ea81347e278c731bf6de271bdc6d43e628e4685b2cb8c1a::no_523 {
    struct NO_523 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_523, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_523>(arg0, 9, b"NO_523", b"Nobguy", b"A new meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5a03fe8-dc5f-4c9f-922a-a1bd8c246464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_523>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO_523>>(v1);
    }

    // decompiled from Move bytecode v6
}


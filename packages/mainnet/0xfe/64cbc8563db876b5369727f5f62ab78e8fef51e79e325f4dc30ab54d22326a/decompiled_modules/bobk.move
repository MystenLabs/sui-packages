module 0xfe64cbc8563db876b5369727f5f62ab78e8fef51e79e325f4dc30ab54d22326a::bobk {
    struct BOBK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBK>(arg0, 9, b"BOBK", b"Bobr Kurwa", b"Meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d95a7565-6152-46ca-8e52-33ea56e66744.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBK>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xcaa93af302e8397102dc6097c7fddfc5814f9ef1d37a7e9d53fb5b346d4f28f8::owt {
    struct OWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWT>(arg0, 9, b"OWT", b"Orcha Wave", b"Nothing but just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f51c4f24-06f0-4057-b0d7-a1f245e9c530.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWT>>(v1);
    }

    // decompiled from Move bytecode v6
}


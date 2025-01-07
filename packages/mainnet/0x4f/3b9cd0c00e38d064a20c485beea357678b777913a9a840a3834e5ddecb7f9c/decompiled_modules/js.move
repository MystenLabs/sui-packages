module 0x4f3b9cd0c00e38d064a20c485beea357678b777913a9a840a3834e5ddecb7f9c::js {
    struct JS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JS>(arg0, 9, b"JS", b"Juse", x"4368c3ba61204a65737375", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bb07206-ca3d-4e53-90b0-8897cf8dcb62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JS>>(v1);
    }

    // decompiled from Move bytecode v6
}


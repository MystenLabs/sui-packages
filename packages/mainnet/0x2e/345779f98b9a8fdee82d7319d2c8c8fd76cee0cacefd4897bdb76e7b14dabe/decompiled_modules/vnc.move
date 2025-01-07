module 0x2e345779f98b9a8fdee82d7319d2c8c8fd76cee0cacefd4897bdb76e7b14dabe::vnc {
    struct VNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNC>(arg0, 9, b"VNC", b"VN Coin", b"Meme coin of Viet Nam. \"Viet Nam no.1\". \"Long live the great HO CHI MINH\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5c8964f-eacc-4f48-936d-c5b8f4ffc128.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNC>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x8b0fc442abae5486991943b043fc51099f0a274a7ce1930127b4e8778d5c1992::vnc {
    struct VNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNC>(arg0, 9, b"VNC", b"VN Coin", b"Meme coin of Viet Nam. \"Viet Nam no.1\". \"Long live the great HO CHI MINH\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dce2e547-c7c6-499f-bf00-37bc7fdbe3d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNC>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x421c3b3aa32de1f44224d8f1f3448bb2b54724f935d8274a33104dc83e8d41ca::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 9, b"WW", b"We Wave ", b"Get ready to ride the wave of innovation! Sui Wave .a cutting-edge blockchain project, is thrilled to announce the launch of its highly anticipated token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e24cce06-a203-415b-a6f5-56ea6069e67d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WW>>(v1);
    }

    // decompiled from Move bytecode v6
}


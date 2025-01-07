module 0x9315b429ed27cdfe773ad803c986258805d65cd447e94ea52221bf38c3f954a2::sdpn {
    struct SDPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDPN>(arg0, 9, b"SDPN", b"SuiDolphin", b"From the hidden depths of the sea comes the Suidolphin! A mysterious creature that carries the secret of unexpected riches. Do you dare to dive into the world of crypto with us? Each Suidolphin token is a key to unlocking hidden treasures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a97e6492-bb53-4c1a-8cd3-f98d93333bcb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDPN>>(v1);
    }

    // decompiled from Move bytecode v6
}


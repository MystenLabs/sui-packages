module 0x3b5abd9af3285de476ad2ecae2bbcb225fa49432e405c2df4a4845b29b11f809::tp {
    struct TP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TP>(arg0, 9, b"TP", b"Tech Pulse", b"TechPulse is an innovative cryptocurrency that bridges technology and finance. Seamlessly empowering developers and startups, it fuels groundbreaking projects in the tech industry. Join TechPulse to stay ahead in the digital revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6dc6de0-0624-4236-b6fb-c9757ed0c798.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TP>>(v1);
    }

    // decompiled from Move bytecode v6
}


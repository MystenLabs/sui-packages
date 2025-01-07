module 0xf2bef0344a6721c8a7744e0a846cc3e3c92ef9607e96319ec959509b3a37e925::dvtmute {
    struct DVTMUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVTMUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVTMUTE>(arg0, 9, b"DVTMUTE", b"Mute", b"Dvtmute and", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21192131-927d-4bdf-a8d3-f1614584c33e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVTMUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DVTMUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}


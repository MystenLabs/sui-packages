module 0xed2fa1153a6e3e6a04d9902f31b157c550c60bc82c928a0dca8d4c359a136d42::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"Waves", b"$WAVE Token is a cryptocurrency that builds community through blockchain. With limited supply, it offers value and integrates with DApps and DeFi for fast, low-fee transactions. Its goal is to make blockchain accessible in daily life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d7b004e-ce57-402c-8295-568425be6aa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}


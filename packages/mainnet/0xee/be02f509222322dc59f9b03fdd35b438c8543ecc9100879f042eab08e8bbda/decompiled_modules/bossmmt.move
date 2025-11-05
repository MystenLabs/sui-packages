module 0xeebe02f509222322dc59f9b03fdd35b438c8543ecc9100879f042eab08e8bbda::bossmmt {
    struct BOSSMMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSSMMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSSMMT>(arg0, 6, b"BossMMT", b"Big Boss MMT", b"If there's an MMT, and there's an Baby MMT, Now!!!! THE BIG BOSS MMT is HERE!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762332934405.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSSMMT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSSMMT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


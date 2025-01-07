module 0x1c657d2c18e9b75ff8acef2d0daea99ae0390bb7585babaea08ebd1686ee6b57::dogc {
    struct DOGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGC>(arg0, 9, b"DOGC", b"COOLDOG", b"ICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed848661-6186-4cb4-83b4-e2b2aeb4c2db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGC>>(v1);
    }

    // decompiled from Move bytecode v6
}


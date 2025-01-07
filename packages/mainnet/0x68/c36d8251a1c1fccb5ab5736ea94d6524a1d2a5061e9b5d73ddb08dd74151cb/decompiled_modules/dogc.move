module 0x68c36d8251a1c1fccb5ab5736ea94d6524a1d2a5061e9b5d73ddb08dd74151cb::dogc {
    struct DOGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGC>(arg0, 9, b"DOGC", b"COOLDOG", b"ICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fb2bfaa-99a1-4804-b412-6692acbebeed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGC>>(v1);
    }

    // decompiled from Move bytecode v6
}


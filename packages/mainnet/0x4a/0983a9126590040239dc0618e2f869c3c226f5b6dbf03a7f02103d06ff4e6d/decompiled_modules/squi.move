module 0x4a0983a9126590040239dc0618e2f869c3c226f5b6dbf03a7f02103d06ff4e6d::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUI>(arg0, 9, b"SQUI", b"Squirrel", b"Just for fun. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9198a622-d9fd-4fba-9711-5b901c2887eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


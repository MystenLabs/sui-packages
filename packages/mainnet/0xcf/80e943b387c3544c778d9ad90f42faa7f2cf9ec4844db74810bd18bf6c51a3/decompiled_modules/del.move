module 0xcf80e943b387c3544c778d9ad90f42faa7f2cf9ec4844db74810bd18bf6c51a3::del {
    struct DEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEL>(arg0, 9, b"DEL", b"delveseh", b"DELVESESH YUMMMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6eaeb022-e9a1-4adb-8ae7-72a0faf77c44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEL>>(v1);
    }

    // decompiled from Move bytecode v6
}


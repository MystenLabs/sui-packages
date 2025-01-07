module 0x2d05f9027f8bf79b298025845be998b8c5cf0eda642cf268c1b396ab52dafade::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 9, b"SHEEP", b" SHEEP", b"S H E E P", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ee72090-8ff2-4ef7-b4e1-0c774ac9b559.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}


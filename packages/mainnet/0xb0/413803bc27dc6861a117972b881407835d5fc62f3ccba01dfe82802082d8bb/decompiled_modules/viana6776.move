module 0xb0413803bc27dc6861a117972b881407835d5fc62f3ccba01dfe82802082d8bb::viana6776 {
    struct VIANA6776 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIANA6776, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIANA6776>(arg0, 9, b"VIANA6776", b"NotPIX", b"A token that has a very bright future and is going to be used in a large ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdb3b4ad-a3f3-4f3c-86d2-912b7b7bbe2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIANA6776>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIANA6776>>(v1);
    }

    // decompiled from Move bytecode v6
}


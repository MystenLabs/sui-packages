module 0xaaa77150cfa5c28d52cf6a4603bfc713d993d0d9f7a75cd8c567f47dc88f45b2::derr {
    struct DERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERR>(arg0, 9, b"DERR", b"DEEER", b" CHRISTMAS DEER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec00e3a1-5ea4-4c45-afae-5cfe9a36104a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERR>>(v1);
    }

    // decompiled from Move bytecode v6
}


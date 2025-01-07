module 0xdd1d087ec68b978c1f10757d280c92863972643d9c15c4b153531fe3632eb5bc::bal {
    struct BAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAL>(arg0, 9, b"BAL", b"balloons", b"big balloons ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/819de9e0-841b-43ce-9dba-bcf1cfe55e0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


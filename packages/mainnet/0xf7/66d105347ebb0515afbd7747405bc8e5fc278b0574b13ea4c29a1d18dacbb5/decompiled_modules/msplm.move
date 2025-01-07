module 0xf766d105347ebb0515afbd7747405bc8e5fc278b0574b13ea4c29a1d18dacbb5::msplm {
    struct MSPLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSPLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSPLM>(arg0, 9, b"MSPLM", b"Marsupilam", b"To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4a015f7-261f-4505-914c-2b22468dce1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSPLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSPLM>>(v1);
    }

    // decompiled from Move bytecode v6
}


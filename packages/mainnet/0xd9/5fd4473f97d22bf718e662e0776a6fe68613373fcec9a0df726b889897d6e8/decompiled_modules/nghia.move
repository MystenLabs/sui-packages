module 0xd95fd4473f97d22bf718e662e0776a6fe68613373fcec9a0df726b889897d6e8::nghia {
    struct NGHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGHIA>(arg0, 9, b"NGHIA", b"Vu", b"Truc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09624bb0-991d-4100-85f4-1ef243e4c38b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGHIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGHIA>>(v1);
    }

    // decompiled from Move bytecode v6
}


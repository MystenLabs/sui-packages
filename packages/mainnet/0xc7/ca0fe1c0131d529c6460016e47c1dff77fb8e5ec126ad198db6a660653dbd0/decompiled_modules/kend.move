module 0xc7ca0fe1c0131d529c6460016e47c1dff77fb8e5ec126ad198db6a660653dbd0::kend {
    struct KEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEND>(arg0, 9, b"KEND", b"sjns", b"jdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c690c179-c853-4eb4-9bea-ec9689703cda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEND>>(v1);
    }

    // decompiled from Move bytecode v6
}


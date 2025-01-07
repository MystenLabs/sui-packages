module 0x783a76e818eedea2d9f41066753d156145066be636bb94f06b08acb49065382b::van {
    struct VAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAN>(arg0, 9, b"VAN", b"Van", x"42e1bb99204b696e682056c3a26e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f47c755-3643-43e8-ac75-984c343c14a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


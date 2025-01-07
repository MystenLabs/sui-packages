module 0xa6bc0b67d7bd809089c3654c03633d648422e286da915f8be1691ed7b93ef3d5::xnsldknc {
    struct XNSLDKNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XNSLDKNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XNSLDKNC>(arg0, 9, b"XNSLDKNC", b"Lajdmdmmf", b"Xnksmcm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fc21228-5e2c-46c9-906a-379fe6b8724e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XNSLDKNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XNSLDKNC>>(v1);
    }

    // decompiled from Move bytecode v6
}


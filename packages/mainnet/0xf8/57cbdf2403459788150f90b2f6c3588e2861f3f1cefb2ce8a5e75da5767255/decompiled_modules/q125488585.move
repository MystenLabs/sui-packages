module 0xf857cbdf2403459788150f90b2f6c3588e2861f3f1cefb2ce8a5e75da5767255::q125488585 {
    struct Q125488585 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q125488585, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q125488585>(arg0, 9, b"Q125488585", b"QQ", b"Handsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51760488-0873-4307-8353-5c58e5e92c4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q125488585>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q125488585>>(v1);
    }

    // decompiled from Move bytecode v6
}


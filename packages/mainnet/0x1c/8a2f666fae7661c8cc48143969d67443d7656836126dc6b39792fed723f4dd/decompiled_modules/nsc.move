module 0x1c8a2f666fae7661c8cc48143969d67443d7656836126dc6b39792fed723f4dd::nsc {
    struct NSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSC>(arg0, 9, b"NSC", b"NHU SO CUT", b"Never Heat Upper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0cddf1b-512d-4e53-889f-9acd8a330e9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSC>>(v1);
    }

    // decompiled from Move bytecode v6
}


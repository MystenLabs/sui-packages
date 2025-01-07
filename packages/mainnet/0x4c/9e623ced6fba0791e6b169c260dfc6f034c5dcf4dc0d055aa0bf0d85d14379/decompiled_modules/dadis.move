module 0x4c9e623ced6fba0791e6b169c260dfc6f034c5dcf4dc0d055aa0bf0d85d14379::dadis {
    struct DADIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADIS>(arg0, 9, b"DADIS", b"DADI", b"Dadi is a crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbf88c4e-3da7-43f0-9e6d-0b021c4479cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADIS>>(v1);
    }

    // decompiled from Move bytecode v6
}


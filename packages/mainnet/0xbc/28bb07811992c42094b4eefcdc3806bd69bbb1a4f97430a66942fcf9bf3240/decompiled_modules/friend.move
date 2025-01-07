module 0xbc28bb07811992c42094b4eefcdc3806bd69bbb1a4f97430a66942fcf9bf3240::friend {
    struct FRIEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEND>(arg0, 9, b"FRIEND", b"Friend", b"My Friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b1b2e71-7cdd-4e2b-9e5e-4c3d4a0bd8a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRIEND>>(v1);
    }

    // decompiled from Move bytecode v6
}


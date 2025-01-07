module 0x9e8d525b0a9edf60e3e89d0468b5f84f41bceb50e47c127b9355350a4a71a4fd::ash92 {
    struct ASH92 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH92, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH92>(arg0, 9, b"ASH92", b"Asheblack9", b"Powered by hardwork and productivity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/549b2184-c94f-4eb7-91d5-0304ee2f9abc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH92>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASH92>>(v1);
    }

    // decompiled from Move bytecode v6
}


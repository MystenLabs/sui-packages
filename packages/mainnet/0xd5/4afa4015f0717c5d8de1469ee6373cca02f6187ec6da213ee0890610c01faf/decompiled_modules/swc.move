module 0xd54afa4015f0717c5d8de1469ee6373cca02f6187ec6da213ee0890610c01faf::swc {
    struct SWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWC>(arg0, 9, b"SWC", b"SU We Cats", b"We are cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/989fbd81-89a5-450f-b6db-9b28104920e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWC>>(v1);
    }

    // decompiled from Move bytecode v6
}


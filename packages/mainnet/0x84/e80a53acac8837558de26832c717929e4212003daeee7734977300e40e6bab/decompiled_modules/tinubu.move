module 0x84e80a53acac8837558de26832c717929e4212003daeee7734977300e40e6bab::tinubu {
    struct TINUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINUBU>(arg0, 9, b"TINUBU", b"We", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd44266b-8024-4f3a-b4cd-37296134b8e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}


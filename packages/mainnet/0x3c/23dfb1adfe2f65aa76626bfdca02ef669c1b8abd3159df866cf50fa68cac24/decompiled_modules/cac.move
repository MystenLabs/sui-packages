module 0x3c23dfb1adfe2f65aa76626bfdca02ef669c1b8abd3159df866cf50fa68cac24::cac {
    struct CAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAC>(arg0, 9, b"CAC", b"CACX", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5573035c-5468-4208-8e77-a55f6f39f152.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAC>>(v1);
    }

    // decompiled from Move bytecode v6
}


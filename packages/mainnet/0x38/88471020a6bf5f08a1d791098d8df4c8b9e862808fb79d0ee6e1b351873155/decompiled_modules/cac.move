module 0x3888471020a6bf5f08a1d791098d8df4c8b9e862808fb79d0ee6e1b351873155::cac {
    struct CAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAC>(arg0, 9, b"CAC", b"CACX", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0cd158fe-d76f-4440-b87a-8d28acd7d002.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAC>>(v1);
    }

    // decompiled from Move bytecode v6
}


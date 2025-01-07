module 0xa46ddd1528d9ca343136d9a9e3452f1ba0e6e82c1aca295f150155e2e46096bf::helo {
    struct HELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELO>(arg0, 9, b"HELO", b"Hello", b"Non", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfc5e075-de95-4242-92b0-e0aaddeb0fd0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELO>>(v1);
    }

    // decompiled from Move bytecode v6
}


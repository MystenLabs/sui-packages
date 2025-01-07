module 0x6a77198ce041417b86637ca944f0f8d57920971766bc73e0fd7f2b517ff45653::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 9, b"WAVE", b"Durov", x"5468697320746f6b656e20776173206372656174656420696e206f7264657220746f20737570706f72742020506176656c204475726f762e0a506176656c2056616c6572796576696368204475726f762069732061205275737369616e20746563686e6f6c6f677920656e7472657072656e6575722062657374206b6e6f776e2061732074686520666f756e64657220616e6420636869656620657865637574697665206f666669636572206f662054656c656772616d2c2061206d6573736167696e6720706c6174666f726d206c61756e6368656420696e20323031332e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c0bf358-90ac-4e8a-b7bf-abaa19c612d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}


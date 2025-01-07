module 0xa284b16555f8439cc82f71e8e88c83da6745a86f691ca7d66e2e23e270527d4b::cldogs {
    struct CLDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLDOGS>(arg0, 9, b"CLDOGS", b"CLDOG", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b8bd9d8-9b0e-45c8-961d-b09a63a6cd50.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}


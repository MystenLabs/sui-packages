module 0xeb9188a6ae98273bea7ab011351debf493b6e82a967a1eb49603253304363329::dogc {
    struct DOGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGC>(arg0, 9, b"DOGC", b"COLDOG", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e484bd9a-43a7-497a-b1c6-a43c3b22d4d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGC>>(v1);
    }

    // decompiled from Move bytecode v6
}


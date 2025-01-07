module 0x54481d6eada9c5fa795ca9036bfc05228d87898154983444b9461f9b01917c7f::dogc {
    struct DOGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGC>(arg0, 9, b"DOGC", b"COLDOG", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d66ba2ab-d4ab-427d-9007-d7e221868256.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGC>>(v1);
    }

    // decompiled from Move bytecode v6
}


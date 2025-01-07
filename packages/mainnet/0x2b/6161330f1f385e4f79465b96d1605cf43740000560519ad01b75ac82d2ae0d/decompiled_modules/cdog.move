module 0x2b6161330f1f385e4f79465b96d1605cf43740000560519ad01b75ac82d2ae0d::cdog {
    struct CDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDOG>(arg0, 9, b"CDOG", b"CDOGL", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3bf72e3-383a-496c-b24b-7b9291dd3871.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x6f7d0c520a63c530795d791be7feed246de6081792231184c455641c74e7d060::cxv {
    struct CXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXV>(arg0, 9, b"CXV", b"DHF", b"XCB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab515d11-af98-4268-bf82-ee629e43d7af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXV>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdef9044fa2824e82a104940e8c9949b0444f58f8d8a1a0a60dfede38df7d7e5f::ogw {
    struct OGW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGW>(arg0, 9, b"OGW", b"OGWay", b"Oggy way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/755fc36c-8bd9-44ce-aa9b-df4dcf27c04f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGW>>(v1);
    }

    // decompiled from Move bytecode v6
}


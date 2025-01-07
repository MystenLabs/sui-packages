module 0x902c5e4a52798cdcfeed48ba497bb0a01dd5420a17e4215e4294a057554b95b6::uhggff {
    struct UHGGFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHGGFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHGGFF>(arg0, 9, b"UHGGFF", b"Uhggyyy", b"Ggvgf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3391903e-c113-4738-8b16-e9b34ae71842.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHGGFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UHGGFF>>(v1);
    }

    // decompiled from Move bytecode v6
}


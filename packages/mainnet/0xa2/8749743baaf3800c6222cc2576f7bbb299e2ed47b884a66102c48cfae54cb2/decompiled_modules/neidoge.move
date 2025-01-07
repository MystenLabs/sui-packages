module 0xa28749743baaf3800c6222cc2576f7bbb299e2ed47b884a66102c48cfae54cb2::neidoge {
    struct NEIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIDOGE>(arg0, 9, b"NEIDOGE", b"SecNeiro", b"The Meme Dominant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adcf32b5-ed65-4bf3-8c13-9579e5f17bfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


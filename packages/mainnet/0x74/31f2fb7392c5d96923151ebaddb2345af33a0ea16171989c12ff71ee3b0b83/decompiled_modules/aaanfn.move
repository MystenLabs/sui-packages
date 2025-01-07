module 0x7431f2fb7392c5d96923151ebaddb2345af33a0ea16171989c12ff71ee3b0b83::aaanfn {
    struct AAANFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAANFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAANFN>(arg0, 9, b"AAANFN", b"eeueueu", b"fnajsnfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/269149d3-b68c-411a-8493-b9bf9c9c51c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAANFN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAANFN>>(v1);
    }

    // decompiled from Move bytecode v6
}


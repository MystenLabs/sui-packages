module 0x2e6d3b02912a2b98582696d0b49ec3af07fa6aff5f7de9e78cb1cf8225b8f03e::nampervn {
    struct NAMPERVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMPERVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMPERVN>(arg0, 9, b"NAMPERVN", b"NamPer", b"NamPerVn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/870c937a-29f4-4237-8d22-929951d108f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMPERVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMPERVN>>(v1);
    }

    // decompiled from Move bytecode v6
}


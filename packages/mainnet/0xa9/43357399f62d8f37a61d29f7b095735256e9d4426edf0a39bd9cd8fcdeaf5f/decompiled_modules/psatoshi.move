module 0xa943357399f62d8f37a61d29f7b095735256e9d4426edf0a39bd9cd8fcdeaf5f::psatoshi {
    struct PSATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSATOSHI>(arg0, 9, b"PSATOSHI", b"peter todd", b"peter todd is satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20b15b08-ae15-471d-8d41-95209c0089ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


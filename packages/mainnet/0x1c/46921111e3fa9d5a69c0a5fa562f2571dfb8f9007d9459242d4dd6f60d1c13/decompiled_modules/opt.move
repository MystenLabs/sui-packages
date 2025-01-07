module 0x1c46921111e3fa9d5a69c0a5fa562f2571dfb8f9007d9459242d4dd6f60d1c13::opt {
    struct OPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPT>(arg0, 9, b"OPT", b"Optimistic", b"Always be optimistic and confident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85a5aba5-682a-4813-ab1f-30db06adf6d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x80f655b43b5dcf498f4fdebee09660e8a620ea8403cd547ba4e142443181cd44::ept {
    struct EPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPT>(arg0, 9, b"EPT", b"EPoint ", b"East or West EarningPoint is best ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca47a1eb-c816-42c8-96ba-4cd78978ed88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPT>>(v1);
    }

    // decompiled from Move bytecode v6
}


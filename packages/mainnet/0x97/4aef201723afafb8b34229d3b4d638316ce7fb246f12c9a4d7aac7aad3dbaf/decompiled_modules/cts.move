module 0x974aef201723afafb8b34229d3b4d638316ce7fb246f12c9a4d7aac7aad3dbaf::cts {
    struct CTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTS>(arg0, 9, b"CTS", b"Catoshi", x"4d6565777721204361746f73686920636174206973206865726520f09f9088e2808de2ac9b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b29653ec-ffe2-47f4-a783-1518c45bfc4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTS>>(v1);
    }

    // decompiled from Move bytecode v6
}


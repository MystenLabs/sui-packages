module 0xddc87ba42617cfaf44982dc9bed28b455e8eb827e5532ad21ee1fc1f6cc6dcef::ott {
    struct OTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTT>(arg0, 9, b"OTT", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28e5b414-f2e7-4790-973a-869896f6eef4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTT>>(v1);
    }

    // decompiled from Move bytecode v6
}


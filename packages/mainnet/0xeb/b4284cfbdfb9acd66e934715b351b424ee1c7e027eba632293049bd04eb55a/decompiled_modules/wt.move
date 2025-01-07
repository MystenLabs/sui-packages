module 0xebb4284cfbdfb9acd66e934715b351b424ee1c7e027eba632293049bd04eb55a::wt {
    struct WT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WT>(arg0, 9, b"WT", b"Wave Test", b"Test Token on the wave wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c3602dd-1a39-4819-ba26-d81652323679.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WT>>(v1);
    }

    // decompiled from Move bytecode v6
}


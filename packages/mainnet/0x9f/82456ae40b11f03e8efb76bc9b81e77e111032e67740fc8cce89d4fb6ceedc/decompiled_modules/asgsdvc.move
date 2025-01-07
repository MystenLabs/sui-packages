module 0x9f82456ae40b11f03e8efb76bc9b81e77e111032e67740fc8cce89d4fb6ceedc::asgsdvc {
    struct ASGSDVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASGSDVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASGSDVC>(arg0, 9, b"ASGSDVC", b"ASDAS", b"VBNVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43e14d2a-50a7-4da6-9674-6fb7689549c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASGSDVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASGSDVC>>(v1);
    }

    // decompiled from Move bytecode v6
}


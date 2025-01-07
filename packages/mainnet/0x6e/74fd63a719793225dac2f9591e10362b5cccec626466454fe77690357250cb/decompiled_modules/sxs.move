module 0x6e74fd63a719793225dac2f9591e10362b5cccec626466454fe77690357250cb::sxs {
    struct SXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXS>(arg0, 9, b"SXS", b"SEXY SUI", b"Everyone turning their head to sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71a8751a-2415-4903-b96f-f17678071e77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SXS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1ce9173ad823ebcbb2f4aa14343d5968ea575cb102d458f321a773633b552624::doughcake {
    struct DOUGHCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUGHCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUGHCAKE>(arg0, 9, b"DOUGHCAKE", b"Cake", b"Cake is an edibles that is loved by everyone. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0b6de54-7d5f-47d0-9bd8-b2e39ccfc599.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUGHCAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOUGHCAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}


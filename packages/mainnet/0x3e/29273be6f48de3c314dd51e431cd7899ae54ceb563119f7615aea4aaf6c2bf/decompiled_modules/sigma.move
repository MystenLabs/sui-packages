module 0x3e29273be6f48de3c314dd51e431cd7899ae54ceb563119f7615aea4aaf6c2bf::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMA>(arg0, 9, b"SIGMA", b"Sigma male", b"Sigma male representation of alpha male", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/117dcb85-f6c1-46b6-8abc-e8befb7b3354.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}


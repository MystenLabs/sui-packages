module 0x1c31b883246478eb29ad6d8ecb5598ce82a6f941935bd3224dacf5a1d7608b88::uw {
    struct UW has drop {
        dummy_field: bool,
    }

    fun init(arg0: UW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UW>(arg0, 9, b"UW", b"UWUW", b"Uwuwuwu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e9b52f2-a95c-44cc-8317-a129e595a242.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UW>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x757350c94a96bde228ecb425fac3028242ca1b98be33676872edee76bea71d79::bharat {
    struct BHARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHARAT>(arg0, 9, b"BHARAT", b"Bheema ", b"That's a meme coins inspired by Mahabharata ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a16b204-1819-41f4-8a1d-00fffd8e3c66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHARAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHARAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


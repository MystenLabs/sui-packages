module 0xb990e3a78141270ec1385cde34710863fcbece8c763e115fc7bb04441a8b714f::lhe {
    struct LHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LHE>(arg0, 9, b"LHE", b"Lighthouse", b"Unleash the fun with LHECoin: The crypto that's barking up the blockchain with pawsitively hilarious memes and tail-wagging rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2941928a-04bc-4234-b39e-37ca9d619547.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LHE>>(v1);
    }

    // decompiled from Move bytecode v6
}


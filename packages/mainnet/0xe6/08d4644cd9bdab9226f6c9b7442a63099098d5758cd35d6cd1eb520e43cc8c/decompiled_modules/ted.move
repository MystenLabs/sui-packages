module 0xe608d4644cd9bdab9226f6c9b7442a63099098d5758cd35d6cd1eb520e43cc8c::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 9, b"TED", b"tedd", b"Cuddle up to success with TeddCoin: The cozy cryptocurrency that's bringing warmth to your portfolio, delivering soft profits and comforting gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/015e655b-3c99-41aa-9251-0719fe4523a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TED>>(v1);
    }

    // decompiled from Move bytecode v6
}


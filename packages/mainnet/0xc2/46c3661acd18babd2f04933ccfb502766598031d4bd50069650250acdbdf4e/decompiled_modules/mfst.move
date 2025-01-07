module 0xc246c3661acd18babd2f04933ccfb502766598031d4bd50069650250acdbdf4e::mfst {
    struct MFST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFST>(arg0, 9, b"MFST", b"MemeFiesta", b"The ultimate party for all meme coins. MemeFiesta brings fun and chaos to crypto! Trade, hold, or just laugh along as this wild coin pumps and dumps at every fiesta it finds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec915405-3966-4af3-b2d4-195dc65aee45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFST>>(v1);
    }

    // decompiled from Move bytecode v6
}


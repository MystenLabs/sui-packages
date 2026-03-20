module 0x228c7da8c03be38ada8d203b8d9ae80ee56f6348a4629678e8c9df436663acd9::pop_mmzi04qot3u1 {
    struct POP_MMZI04QOT3U1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP_MMZI04QOT3U1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP_MMZI04QOT3U1>(arg0, 9, b"POP", b"POP", b"$POP on sui blockchain will make crypto and trading more affordable and risk worthy especially to beginners. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmPnM1tLpEyrytHTdQUwyTyDRjJ4NTa7XQBufFwVibRTtT")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP_MMZI04QOT3U1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP_MMZI04QOT3U1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


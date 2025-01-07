module 0xddf6de0af2e852dfad1eb7008bf1cb7897cbf2b71f2a98d5f95760d2eb31512f::shrk {
    struct SHRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRK>(arg0, 9, b"SHRK", b"shamrock", b"Lucky, happy, funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0f8397e-a600-437f-ad2b-61c85b91fea7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRK>>(v1);
    }

    // decompiled from Move bytecode v6
}


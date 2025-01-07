module 0x6b35f684693c17af6797acaf4aa04c39f07ebb861f78ef12507f2e1315d26e8d::mrl {
    struct MRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRL>(arg0, 9, b"MRL", b"EMERALD ", b"$MRL is asset of Emerald Project these are entertainment, earning and more! C.A (TRX): TAZeZKtAMw2VC2RfCc1uNzBYKuFFzqgAts (BaseETH): 0xa3FB7Ac955f0a173B60cCABD4f9ECD6B6229be9f (SUI): current C.A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d708650a-6b5c-48b0-878e-67ba7f8dbe2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRL>>(v1);
    }

    // decompiled from Move bytecode v6
}


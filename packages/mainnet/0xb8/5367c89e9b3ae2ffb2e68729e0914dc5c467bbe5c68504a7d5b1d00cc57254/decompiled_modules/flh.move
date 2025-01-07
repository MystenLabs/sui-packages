module 0xb85367c89e9b3ae2ffb2e68729e0914dc5c467bbe5c68504a7d5b1d00cc57254::flh {
    struct FLH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLH>(arg0, 9, b"FLH", b"FJG", b"So I can get the day ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/155adf3a-2a54-4a3e-9173-daa2b0962d73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLH>>(v1);
    }

    // decompiled from Move bytecode v6
}


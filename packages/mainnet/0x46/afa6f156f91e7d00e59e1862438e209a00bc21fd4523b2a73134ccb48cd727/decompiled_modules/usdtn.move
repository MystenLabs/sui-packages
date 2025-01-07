module 0x46afa6f156f91e7d00e59e1862438e209a00bc21fd4523b2a73134ccb48cd727::usdtn {
    struct USDTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTN>(arg0, 9, b"USDTN", b"ERRORS", b"404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14c0822e-bb07-49e6-b7e3-a91d733b001a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTN>>(v1);
    }

    // decompiled from Move bytecode v6
}


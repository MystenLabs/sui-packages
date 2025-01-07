module 0x59b97bbd98af380324857fe569c358c10014ae4f9efaa53bb1a340ee3af1986::zfn {
    struct ZFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFN>(arg0, 9, b"ZFN", b"ZAFRAN", b"My Boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/295d56d8-3bb0-4510-a6a8-b641ca887425.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZFN>>(v1);
    }

    // decompiled from Move bytecode v6
}


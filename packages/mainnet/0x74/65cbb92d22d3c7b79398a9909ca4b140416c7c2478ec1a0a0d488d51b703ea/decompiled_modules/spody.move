module 0x7465cbb92d22d3c7b79398a9909ca4b140416c7c2478ec1a0a0d488d51b703ea::spody {
    struct SPODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPODY>(arg0, 9, b"SPODY", b"Spoody", b"Spoody is unimpressed with da pumps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ea3ea57-521d-4f1b-be93-f16fb77884b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPODY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x24dadda43b9468da312962cf66c84e41071c1e36200833e2fa24b428cd43e9a::hehes {
    struct HEHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHES>(arg0, 9, b"HEHES", b"Heheit", b"THAT WHAT IT NO YOU CAN HELP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/899e28de-f897-494c-8b54-f47a713606d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHES>>(v1);
    }

    // decompiled from Move bytecode v6
}


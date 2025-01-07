module 0xef406446fb195b913863b7fa3063abc3bc3921e32567912182150146fbc57607::esoo {
    struct ESOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESOO>(arg0, 9, b"ESOO", b"endsoon", b"ending it soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbf8cdea-4e6c-40b0-baf5-95f2462b3045.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESOO>>(v1);
    }

    // decompiled from Move bytecode v6
}


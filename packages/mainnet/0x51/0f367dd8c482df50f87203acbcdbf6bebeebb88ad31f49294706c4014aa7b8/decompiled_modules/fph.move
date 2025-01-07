module 0x510f367dd8c482df50f87203acbcdbf6bebeebb88ad31f49294706c4014aa7b8::fph {
    struct FPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPH>(arg0, 9, b"FPH", b"Phoenix", b"Dark phoenix token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b776dfb-781f-4691-8f00-bfef8b236d91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FPH>>(v1);
    }

    // decompiled from Move bytecode v6
}


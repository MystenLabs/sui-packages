module 0xeb7d01f5bc2bae428fd5bfbf44b6c12be8371401455721ff65983ccc8908c151::labu {
    struct LABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABU>(arg0, 9, b"LABU", b"LABUBU", b"WE WILL MAKE LABUBU COIN TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d111e3fd-c0ad-482f-988c-4a8d30f16e54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABU>>(v1);
    }

    // decompiled from Move bytecode v6
}


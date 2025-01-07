module 0xc8597178bc8469001908c1e2d647fd36ba120d0ca4bd5af522b2d03924f5a389::sukha {
    struct SUKHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKHA>(arg0, 9, b"SUKHA", b"Sukh", b"It's good tokens buy it's good in future and buy token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f3f42e2-2047-4b9e-af5b-6f0d627124be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKHA>>(v1);
    }

    // decompiled from Move bytecode v6
}


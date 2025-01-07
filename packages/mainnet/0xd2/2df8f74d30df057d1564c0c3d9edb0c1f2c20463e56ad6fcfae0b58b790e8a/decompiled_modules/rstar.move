module 0xd22df8f74d30df057d1564c0c3d9edb0c1f2c20463e56ad6fcfae0b58b790e8a::rstar {
    struct RSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSTAR>(arg0, 9, b"RSTAR", b"RedStar", b"For all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/265b354e-3060-412e-94e8-ef25d561edea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


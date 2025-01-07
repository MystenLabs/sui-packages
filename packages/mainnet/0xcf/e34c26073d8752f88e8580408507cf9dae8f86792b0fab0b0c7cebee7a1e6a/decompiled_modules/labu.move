module 0xcfe34c26073d8752f88e8580408507cf9dae8f86792b0fab0b0c7cebee7a1e6a::labu {
    struct LABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABU>(arg0, 9, b"LABU", b"Labubu", b"Unique pumpkin doll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86f396f3-36fd-410f-832f-fcef607c9e52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x8b6f3e9273af24e80b155cbda00606ca2b9363869b1b0802fdc85bc500496a07::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 9, b"MAGA", b"MagaPump", b"trump will win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe319432-976e-4bc7-b52e-712f0e1e2245.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}


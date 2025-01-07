module 0x87d8790b6dd1d4a2490993931099655e6f88209ff43d33708d557082b09e8c04::troa {
    struct TROA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROA>(arg0, 9, b"TROA", b"TrumpOnAir", x"546f2063656c65627261746520f09fa5822020f09f8e8920746865206e657720707265736964656e74206f662074686520556e6974656420537461746573206f6620416d657269636120446f6e616c64204a205472756d7020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99c8caac-385f-4376-86e3-6823bb32209a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROA>>(v1);
    }

    // decompiled from Move bytecode v6
}


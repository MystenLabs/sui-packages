module 0x583b961c5d08c772ca604003ae9c2ef729db43ea623f011092a959e42acd2c11::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 9, b"LUCE", b"Luce", b"Official Mascot of the Holy Year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d68e4193-cc73-4dbb-8d70-50c83f85c902.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}


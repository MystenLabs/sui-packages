module 0x7a67fc3a3441c3c0208d125fb4773e8e725aca867fefb3b153733debac2b0e86::marvinop {
    struct MARVINOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVINOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVINOP>(arg0, 9, b"MARVINOP", b"Miss", b"Detroit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a96ec0a-e039-4c10-b360-0a01e209c3e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVINOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARVINOP>>(v1);
    }

    // decompiled from Move bytecode v6
}


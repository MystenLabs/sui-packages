module 0x8d8d60d6135f62e6c279d84e3553222a362800887ffd07009061925bcdc38881::occ {
    struct OCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCC>(arg0, 9, b"OCC", b"Ococ", b"Ococ is a little lovely boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6da2f310-cfed-4a4c-ac0b-3b15e4fde076.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCC>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x85b0a8a3d6220d4d000d62a9c374eb4f19e93b9f43d7f05add9342ce78aced76::teki {
    struct TEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEKI>(arg0, 9, b"TEKI", b"Teki con", b"Tekicon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9a966d1-c4de-4726-8e2d-a260785265e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x547a39bb9a573c4bee59a58bfd342904e79ef63e9615702717f77669728c246a::rathva {
    struct RATHVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATHVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATHVA>(arg0, 9, b"RATHVA", b"Mongo", b"Muje Aacha laga ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab99e8fe-8ad5-4c51-864a-3d4073facce3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATHVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATHVA>>(v1);
    }

    // decompiled from Move bytecode v6
}


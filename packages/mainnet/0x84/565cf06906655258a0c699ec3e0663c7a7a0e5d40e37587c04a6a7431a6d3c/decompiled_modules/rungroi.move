module 0x84565cf06906655258a0c699ec3e0663c7a7a0e5d40e37587c04a6a7431a6d3c::rungroi {
    struct RUNGROI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNGROI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNGROI>(arg0, 9, b"RUNGROI", b"nhanhhoa", b"HAHAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b514587-973c-4b66-8dc8-2529769d1404.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNGROI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUNGROI>>(v1);
    }

    // decompiled from Move bytecode v6
}


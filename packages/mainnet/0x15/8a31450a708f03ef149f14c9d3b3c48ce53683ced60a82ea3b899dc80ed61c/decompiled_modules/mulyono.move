module 0x158a31450a708f03ef149f14c9d3b3c48ce53683ced60a82ea3b899dc80ed61c::mulyono {
    struct MULYONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MULYONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULYONO>(arg0, 9, b"MULYONO", b"Mulyo", b"Mulyono is the best token for future kingdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25754591-d744-4b58-97b3-423e8f1e2585.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULYONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULYONO>>(v1);
    }

    // decompiled from Move bytecode v6
}


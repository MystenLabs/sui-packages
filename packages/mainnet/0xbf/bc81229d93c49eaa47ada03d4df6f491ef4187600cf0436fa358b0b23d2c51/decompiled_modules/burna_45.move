module 0xbfbc81229d93c49eaa47ada03d4df6f491ef4187600cf0436fa358b0b23d2c51::burna_45 {
    struct BURNA_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNA_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNA_45>(arg0, 9, b"BURNA_45", b"Burna", b"For fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f265aa2a-7055-4a8d-aa6f-2851156e7372.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNA_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURNA_45>>(v1);
    }

    // decompiled from Move bytecode v6
}


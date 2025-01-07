module 0x9b2b9725c01a8d8d7cf3f7437877d84488ef648873813e0cf02c3e74ae6b349b::quantum {
    struct QUANTUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTUM>(arg0, 6, b"Quantum", b"H^\\Psi(r)=E\\Psi(r)", x"50736928722c74293d485e50736928722c74290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qq_d7c5e591c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTUM>>(v1);
    }

    // decompiled from Move bytecode v6
}


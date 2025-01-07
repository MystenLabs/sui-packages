module 0x8d3a14cb876477b513f87da1cb2b3d3466552b1e3a1f567bdac2fc031004795a::quantum {
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


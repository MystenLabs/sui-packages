module 0x559e7d821017070e50bd48ee8f6eaac040472353ef30156afaa47f1927e12410::bpuj {
    struct BPUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUJ>(arg0, 9, b"BPUJ", b"kuilop", b"the most", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3ccc535-b1a2-426e-87b7-d4cb2faebc7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


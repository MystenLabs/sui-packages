module 0x3e76626c086a45163eb64fa147a1c472511216a225b4d6b867a56e3da63dfd71::veloz {
    struct VELOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VELOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VELOZ>(arg0, 6, b"VELOZ", b"VELOZ PAY", b"Step into the future of digital transactions with VelozPay, the ultimate payment gateway powered by the unparalleled speed and efficiency of the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_203224_968_7345723cb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VELOZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VELOZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xbb49bc2e02ebc92aa4b91b521a965e4aebf30e529e8b9770efeb30c5265bfa47::glow {
    struct GLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GLOW>(arg0, 6, b"GLOW", b"egahiglory", b"A family that prays together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000136315_89fc49a3b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLOW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


module 0x24b996f4e188dcbf3bd7858f08ae1a19294470065de5fccfeb535e0835661f4e::boppy {
    struct BOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOPPY>(arg0, 6, b"BOPPY", b"Boppy the bat", b" Boppy the Bat - The meme coin taking flight on #Sui  | Cute, fast, and ready to soar  | Join the colony! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_28_12_41_03_49fad74344.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


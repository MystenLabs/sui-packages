module 0x30e7ea20ad891e704f3f725c4a92d237beb5646acbe055b5088713e8c79f0172::suirats {
    struct SUIRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRATS>(arg0, 6, b"SUIRATS", b"SUI RATS", b"RATS LFGGGGGGGGGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rats_65d34cc176.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}


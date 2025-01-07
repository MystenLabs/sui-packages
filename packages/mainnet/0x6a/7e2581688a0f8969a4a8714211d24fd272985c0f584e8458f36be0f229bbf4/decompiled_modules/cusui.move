module 0x6a7e2581688a0f8969a4a8714211d24fd272985c0f584e8458f36be0f229bbf4::cusui {
    struct CUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSUI>(arg0, 6, b"CUSUI", b"CULT SUI", b"CULT Sui motivation of the solana token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cult_c5c701b125.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


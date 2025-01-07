module 0x398bf23b48364326148b36d749679631fd800c7722fd1c6a0c8d095504cf8dab::bluechips {
    struct BLUECHIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECHIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECHIPS>(arg0, 6, b"BLUECHIPS", b"BLUECHIPS on SUINETWORK", b"Bluechips on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Chips_06d5fedbc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECHIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECHIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}


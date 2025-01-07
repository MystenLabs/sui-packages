module 0x6a6e54fdecadb15c505c445c44bb2b7af5b854b0f554c4b7d044b0b7db475811::derpy {
    struct DERPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERPY>(arg0, 6, b"DERPY", b"Derpy", b"Only Derps allowed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_ea010080b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


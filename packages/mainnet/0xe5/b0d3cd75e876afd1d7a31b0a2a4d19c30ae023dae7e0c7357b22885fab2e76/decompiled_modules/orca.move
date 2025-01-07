module 0xe5b0d3cd75e876afd1d7a31b0a2a4d19c30ae023dae7e0c7357b22885fab2e76::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"SUI ORCA", b"ORCA ON SUI community today and be part of the next wave of meme token success on the SUI blockchain. Get ready for a journey full of laughter, innovation, and opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6309616238875231235_3c354b6ae0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}


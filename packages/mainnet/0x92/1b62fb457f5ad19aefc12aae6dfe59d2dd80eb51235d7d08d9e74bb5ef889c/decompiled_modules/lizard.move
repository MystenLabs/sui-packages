module 0x921b62fb457f5ad19aefc12aae6dfe59d2dd80eb51235d7d08d9e74bb5ef889c::lizard {
    struct LIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZARD>(arg0, 6, b"LIZARD", b"SUI LIZARD", b"The lizard combined with its sui web and sticky arms is coming to be a meme project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_28_15_55_44_1_11008c68e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}


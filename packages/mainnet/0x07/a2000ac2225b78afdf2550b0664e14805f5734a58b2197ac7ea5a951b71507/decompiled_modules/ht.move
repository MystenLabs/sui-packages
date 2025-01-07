module 0x7a2000ac2225b78afdf2550b0664e14805f5734a58b2197ac7ea5a951b71507::ht {
    struct HT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HT>(arg0, 6, b"HT", b"Hype Tracker", x"4879706520546f6b656e20547261636b65720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0b_mbky_K_400x400_58df4ec629.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HT>>(v1);
    }

    // decompiled from Move bytecode v6
}


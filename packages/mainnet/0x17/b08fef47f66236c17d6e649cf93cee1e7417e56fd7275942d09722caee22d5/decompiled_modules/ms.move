module 0x17b08fef47f66236c17d6e649cf93cee1e7417e56fd7275942d09722caee22d5::ms {
    struct MS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS>(arg0, 6, b"MS", b"MoveSui", b"Our beloved MOVE community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726146248612_25f209c3bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS>>(v1);
    }

    // decompiled from Move bytecode v6
}


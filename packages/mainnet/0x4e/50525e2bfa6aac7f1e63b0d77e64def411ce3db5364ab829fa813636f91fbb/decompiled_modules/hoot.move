module 0x4e50525e2bfa6aac7f1e63b0d77e64def411ce3db5364ab829fa813636f91fbb::hoot {
    struct HOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOT>(arg0, 6, b"HOOT", b"Sui Hoot", b"Come fly with me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002076_2981632458.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}


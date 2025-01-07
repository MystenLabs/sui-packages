module 0x4fdc45d903f3ace4bad9ff052bead88f424c97ae945caec5dc946998e5cf5a4b::sub {
    struct SUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUB>(arg0, 6, b"SUB", b"Suibubbles", b"Bubbles splash on suichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_155951_018_a63eb57f56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUB>>(v1);
    }

    // decompiled from Move bytecode v6
}


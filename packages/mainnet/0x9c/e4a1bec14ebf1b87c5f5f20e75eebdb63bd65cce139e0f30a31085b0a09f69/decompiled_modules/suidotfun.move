module 0x9ce4a1bec14ebf1b87c5f5f20e75eebdb63bd65cce139e0f30a31085b0a09f69::suidotfun {
    struct SUIDOTFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOTFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOTFUN>(arg0, 6, b"SUIDOTFUN", b"Sui.fun", b"Sui.fun is a memecoin built for fun in sui network. Trade at your own risk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/65hjh3_69e4e37111.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOTFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOTFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}


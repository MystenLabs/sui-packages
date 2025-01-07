module 0x2bd7bfaba57d8a2908ee95338cee3f114e9f65065fc315f87fe90798cea7c64::grumpy {
    struct GRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPY>(arg0, 6, b"GRUMPY", b"Grumpy Sui", b"Now live! The grumpiest cat on Sui. $GRUMPY when bonding, grumpy when mooning. Always Grumpy errrrrday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031279_ae5069e72d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


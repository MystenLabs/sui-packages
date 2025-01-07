module 0x4e5ca8d85b3c1902c7d83c9134cee5a91999384c61a4a41a17a628b2038a1844::sloink {
    struct SLOINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOINK>(arg0, 6, b"SLOINK", b"Sloink by Matt Furie", b" doesn't worry too much about the future. He's a good listener and he does his best to make the present moment beautiful. There is one thing, he sat on a snail once. He can still hear the crunch of that shell. It haunts him.  does his best.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_22_17_59_24_32c6e00ec5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOINK>>(v1);
    }

    // decompiled from Move bytecode v6
}


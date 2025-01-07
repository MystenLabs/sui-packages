module 0x11d42bf8bfc068fadfe2409d18b39f4296896102636e3db2862bfe850fcea6b4::nonecked {
    struct NONECKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONECKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONECKED>(arg0, 6, b"NONECKED", b"No Neck Ed", b"Ed got no neck for this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030465_11c428544a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONECKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONECKED>>(v1);
    }

    // decompiled from Move bytecode v6
}


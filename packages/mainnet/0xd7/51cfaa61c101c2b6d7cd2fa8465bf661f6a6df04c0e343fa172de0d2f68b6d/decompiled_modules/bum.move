module 0xd751cfaa61c101c2b6d7cd2fa8465bf661f6a6df04c0e343fa172de0d2f68b6d::bum {
    struct BUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUM>(arg0, 9, b"BUM", b"bum", b"here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/29c047ce-335f-4468-a3ed-4b09123eff22.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


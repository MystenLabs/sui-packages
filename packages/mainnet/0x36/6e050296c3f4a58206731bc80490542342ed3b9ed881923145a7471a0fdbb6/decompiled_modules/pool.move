module 0x366e050296c3f4a58206731bc80490542342ed3b9ed881923145a7471a0fdbb6::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOL>(arg0, 6, b"POOL", b"POOL", b"Pool on SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOL>>(v1);
    }

    // decompiled from Move bytecode v6
}


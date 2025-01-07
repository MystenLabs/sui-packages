module 0x889e9208a565ce8ff650c73d14483980b258f934c7adff5e7b6223a1e82ef6cd::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOL>(arg0, 6, b"POOL", b"Pooltokenonsui", b"$POOL isn't just a token; it's a community. Imagine diving into a pool where every splash adds to the fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_Yicq0c_400x400_395de34a86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOL>>(v1);
    }

    // decompiled from Move bytecode v6
}


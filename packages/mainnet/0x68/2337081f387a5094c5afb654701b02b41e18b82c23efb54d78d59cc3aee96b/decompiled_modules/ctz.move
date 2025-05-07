module 0x682337081f387a5094c5afb654701b02b41e18b82c23efb54d78d59cc3aee96b::ctz {
    struct CTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTZ>(arg0, 6, b"CTZ", b"CATZO", b"CATZO($CTZ) is ready for the great adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9koazg_5303bffb4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


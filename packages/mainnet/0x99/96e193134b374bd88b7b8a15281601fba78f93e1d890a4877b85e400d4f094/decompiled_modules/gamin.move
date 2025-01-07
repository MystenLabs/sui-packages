module 0x9996e193134b374bd88b7b8a15281601fba78f93e1d890a4877b85e400d4f094::gamin {
    struct GAMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMIN>(arg0, 6, b"GAMIN", b"MegaminOnSUI", b"NO SUI TODAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEGAMIN_0b3c99f56c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAMIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


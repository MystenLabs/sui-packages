module 0x26d9272ee89b9a94d184f96cc03b1f653e422f67038607ca775f78b81b031ec9::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 6, b"BRD", b"Birds", b"Fly fly fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005683_f8a726eff8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRD>>(v1);
    }

    // decompiled from Move bytecode v6
}


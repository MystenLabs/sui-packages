module 0x9d9b39a5ec8e08fe82ed720025e88fa2423b8e5c872dccabba366afac449ae14::babytad {
    struct BABYTAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTAD>(arg0, 6, b"BABYTAD", b"Baby TAD", b"Baby TAD on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_16_d241a2f8c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


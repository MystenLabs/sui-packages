module 0x261918e93ba276b15d26483fba77afc9cb5550a6265af41f0044816efceed45::ratz {
    struct RATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATZ>(arg0, 6, b"RATZ", b"SUI RATZ", b"I'm the fastest Ratz on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TATTOO_153a864cff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


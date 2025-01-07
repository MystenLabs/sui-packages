module 0x1554400962d768b18cba045ffb3e7aa93346ba803a6cd1a9a04f638aa4f88f29::zwif {
    struct ZWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZWIF>(arg0, 6, b"ZWIF", b"zeek wif hat", b"meow with the hat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zeekhead_e3307dfe_c9f4f2a8fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}


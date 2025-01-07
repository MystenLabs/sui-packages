module 0x119fc447c8cdfa7ca947f18a969b794c75c55104ad83b533afdb6f5c48f2421e::csplo {
    struct CSPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSPLO>(arg0, 6, b"CSPLO", b"CTO SPLO", b"Sorry, which way ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPLO_fc85494dd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}


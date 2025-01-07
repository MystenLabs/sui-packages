module 0xc2b428a4bdfc7584214783c783da5f5610901be9b06d20298e38dc5c24160a27::capoo {
    struct CAPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPOO>(arg0, 6, b"CAPOO", b"SUI Capoo Token", b"Bugcat Capoo on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capoo_6b4d405c7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}


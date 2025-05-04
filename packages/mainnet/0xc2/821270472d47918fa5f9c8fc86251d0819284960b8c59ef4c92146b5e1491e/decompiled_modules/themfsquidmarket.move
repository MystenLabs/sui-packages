module 0xc2821270472d47918fa5f9c8fc86251d0819284960b8c59ef4c92146b5e1491e::themfsquidmarket {
    struct THEMFSQUIDMARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEMFSQUIDMARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEMFSQUIDMARKET>(arg0, 6, b"THEMFSQUIDMARKET", b"THE MF SQUID MARKET", b"THE MF SQUID MARKET MINT PASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/THE_MF_SQUID_MARKET_1_97b23b857d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEMFSQUIDMARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEMFSQUIDMARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}


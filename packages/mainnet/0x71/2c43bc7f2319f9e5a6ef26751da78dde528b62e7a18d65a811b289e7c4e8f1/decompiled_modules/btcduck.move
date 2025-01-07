module 0x712c43bc7f2319f9e5a6ef26751da78dde528b62e7a18d65a811b289e7c4e8f1::btcduck {
    struct BTCDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCDUCK>(arg0, 6, b"BTCDUCK", b"Bitcoin Duck", b"Bitcoin Duck on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zk_L_Ks_Ca_AAYI_Beb_430d68e7a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xfdcbb4ddf070317d8d9b2543dd44d0a4cb8956ee7743b6a27b2c0fc4b8819855::suiq {
    struct SUIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQ>(arg0, 6, b"SUIQ", b"Suiquid", b"Sweet squid is a small, tender cephalopod with a mild, slightly sweet flavor, found in both temperate and tropical waters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_5a3ea7118e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}


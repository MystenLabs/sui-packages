module 0x8530712a84e1bf433bdda5500c87901d5cd6b18859e577f0788e46d6cc5c3139::dida {
    struct DIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDA>(arg0, 6, b"DiDa", b"DI DI DA", b"Our wallets are filling up with wealth, steady as a drip,DI DI DA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241005203032_58bbc74742.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}


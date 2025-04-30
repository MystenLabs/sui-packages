module 0x858a589a48f9d44b3edbac5080fe061f7590be42c806d0098ea240a3c42026f0::helio {
    struct HELIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELIO>(arg0, 6, b"HELIO", b"Helio Sui", b"Meet Helio the cute memecoin on sui chain!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adx86q_cb46b6348c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELIO>>(v1);
    }

    // decompiled from Move bytecode v6
}


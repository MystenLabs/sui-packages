module 0xa49e976f70e62a00f0b6a55445810404e7636d725d32e0b927173b4a6af25890::flamincto {
    struct FLAMINCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMINCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMINCTO>(arg0, 6, b"FLAMINCTO", b"FLAMINGO CTO", b"FLAMINGOCTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mosquito_net_f710ef7e5c.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMINCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAMINCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}


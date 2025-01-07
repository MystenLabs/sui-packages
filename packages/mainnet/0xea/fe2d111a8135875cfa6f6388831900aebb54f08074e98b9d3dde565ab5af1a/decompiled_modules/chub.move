module 0xeafe2d111a8135875cfa6f6388831900aebb54f08074e98b9d3dde565ab5af1a::chub {
    struct CHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUB>(arg0, 6, b"CHUB", b"Chub", b"Traced my penis onto paper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chub_c7e5c541ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}


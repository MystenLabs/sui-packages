module 0xf5e6270b80378cfcdc9a68cc06f35da6987ba2735c05ae11ec3aa4f91a2561eb::puse {
    struct PUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSE>(arg0, 6, b"PUSE", b"PU$E", b"NICE PUSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PUSE_8c0bd06473.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc4641f1b8b586e102bf102cf5f5bd3af03cd6c0ee3cd0d0c1c3c93ccd45c7b8f::chicksui {
    struct CHICKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKSUI>(arg0, 6, b"Chicksui", b"Chickcooksui", b"Chickcook sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003445_dd562aca6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


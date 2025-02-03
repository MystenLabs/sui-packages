module 0xe773762592aa42c94e36f00e2dd4bbf82fb0e592abc8753889ec7f97b7707ff6::albatross {
    struct ALBATROSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALBATROSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALBATROSS>(arg0, 6, b"Albatross", b"AbstractaAlbatross", b"Albatross Token is a cryptocurrency that embodies the majestic spirit of the albatross bird. Like the albatross, our token is designed to soar to great heights. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043733_6419eec760.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALBATROSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALBATROSS>>(v1);
    }

    // decompiled from Move bytecode v6
}


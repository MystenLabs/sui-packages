module 0x8a414cd942943fb40f5239caf85818097f2e96102342efd3450c18bbfb15764a::deepr {
    struct DEEPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPR>(arg0, 6, b"Deepr", b"Deeper", b"The deeper you go. The darker the sea gets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1170_3c910e8d52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPR>>(v1);
    }

    // decompiled from Move bytecode v6
}


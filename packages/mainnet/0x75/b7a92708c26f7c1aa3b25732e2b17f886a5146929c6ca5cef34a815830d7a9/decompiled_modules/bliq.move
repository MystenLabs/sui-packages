module 0x75b7a92708c26f7c1aa3b25732e2b17f886a5146929c6ca5cef34a815830d7a9::bliq {
    struct BLIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLIQ>(arg0, 6, b"Bliq", b"Baby liquor", b"minimeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015551_2101b48db4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}


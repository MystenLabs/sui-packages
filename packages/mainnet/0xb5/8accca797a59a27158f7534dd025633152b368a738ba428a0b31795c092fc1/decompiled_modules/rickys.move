module 0xb58accca797a59a27158f7534dd025633152b368a738ba428a0b31795c092fc1::rickys {
    struct RICKYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKYS>(arg0, 6, b"RICKYS", b"Rickysui", b"Ricky finna smoke you. We comin for wrapped dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_112313_378_c1047cea5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKYS>>(v1);
    }

    // decompiled from Move bytecode v6
}


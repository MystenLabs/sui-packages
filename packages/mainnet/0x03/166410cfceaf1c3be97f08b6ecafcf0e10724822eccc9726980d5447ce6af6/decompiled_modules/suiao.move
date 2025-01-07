module 0x3166410cfceaf1c3be97f08b6ecafcf0e10724822eccc9726980d5447ce6af6::suiao {
    struct SUIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAO>(arg0, 6, b"SUIAO", b"Suiao", b"BIAO on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6749_2cbae5e84b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x86cdda99b63a0b40b92935b79418dfbb70ca55d44778227e807a57eb992750b::duckys {
    struct DUCKYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKYS>(arg0, 6, b"DuckyS", b"Ducky", b"Mario ducky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000095_72900576ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKYS>>(v1);
    }

    // decompiled from Move bytecode v6
}


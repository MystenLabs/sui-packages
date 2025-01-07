module 0x7f9ae7c06226ff7af31eb0e1a73bea545046545a8b40e263b756684f7e16b2e8::bobscope {
    struct BOBSCOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBSCOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBSCOPE>(arg0, 6, b"BobScope", b"BOB", b"Visionary Weirdo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dream_3_8ac5d81548.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBSCOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBSCOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


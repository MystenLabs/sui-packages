module 0xb198b19753d48ebbe3975b4e2286086e7bffb804558ca7d49d369fbb4bd6493c::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"Fiona", b"FionaSui", b"Fiona's journey to stardom began under challenging circumstances. Born six weeks prematurely, she faced significant health challenges that were closely followed by millions worldwide. The Cincinnati Zoo's documentation of her struggle and eventual recovery turned her into a viral sensation, with Fiona becoming a symbol of perseverance and an ambassador for her species", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_FNLR_0cx_400x400_67391a7895.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}


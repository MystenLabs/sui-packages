module 0x28145c7c45410819b9ca695367bf8ed56eb68597fc23ccf1767abe87adc4f421::nekon {
    struct NEKON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKON>(arg0, 6, b"NEKON", b"NEKON MEME", b"NEKON: This is not just another cryptocurrency. It represents the interesting collision of regional culture and the encrypted world. NEKON spreads Japanese culture while also spreading meme culture, so that meme has style, personality and regional represe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_23_36_41_65167df0b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKON>>(v1);
    }

    // decompiled from Move bytecode v6
}


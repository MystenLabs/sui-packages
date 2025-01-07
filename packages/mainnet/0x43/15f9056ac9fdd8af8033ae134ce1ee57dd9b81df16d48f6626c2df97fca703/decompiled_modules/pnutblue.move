module 0x4315f9056ac9fdd8af8033ae134ce1ee57dd9b81df16d48f6626c2df97fca703::pnutblue {
    struct PNUTBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTBLUE>(arg0, 6, b"PNUTBLUE", b"PNUTBLUE SUI", b"Pnutbluesui new meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005031_bbabc7d500.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}


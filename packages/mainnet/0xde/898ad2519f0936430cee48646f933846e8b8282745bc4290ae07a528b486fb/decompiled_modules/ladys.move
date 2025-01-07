module 0xde898ad2519f0936430cee48646f933846e8b8282745bc4290ae07a528b486fb::ladys {
    struct LADYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 6, b"LADYS", b"MILADY", b" LADYS is appropriating the tokenisation model to facilitate the accumulation of meme capital in the era of unstoppable meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HFU_Aj_Cf_400x400_75378d9ef3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x2ef1a15256865072615e9ed89ab298de0fb8499bad15d313be5e603f5bc38b55::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"Suijin", b"Suijin  Shinto god", b"Suijin is the Shinto god of water in Japanese mythology. The Water Kami is the guardian of the fishing folk, and a patron saint of fertility, motherhood, and easy childbirth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suijin_850a7bb402.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x52ae393221a8f3b4d024fdd0ea333d3b0fb2bddf68e460d0a948bdd79db89602::ctc {
    struct CTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTC>(arg0, 6, b"CTC", b"CatCoin", b"Even if no one helps me pursue my lofty ambitions, I will tread through the snow and reach the mountain peak on my own.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_111_ece38bf5dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTC>>(v1);
    }

    // decompiled from Move bytecode v6
}


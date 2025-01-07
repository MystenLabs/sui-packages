module 0x1ac7948f6c569667b83768309e28d5ca5272935d4c173480aae4e04b74c853de::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 6, b"Cats", b"Cats on sui", b"Cats are an iconic part of the internet, with images and videos of domestic cats being some of the most viewed content on the web. Some say that cat-related content contributes to how people interact with media and culture. Research suggests that viewing cat media online can be related to positive emotions, and may even work as a form of digital therapy or stress relief for some users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2486_95f2546074.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}


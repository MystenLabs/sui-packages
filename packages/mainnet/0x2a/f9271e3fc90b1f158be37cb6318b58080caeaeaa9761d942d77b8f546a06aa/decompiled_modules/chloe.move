module 0x2af9271e3fc90b1f158be37cb6318b58080caeaeaa9761d942d77b8f546a06aa::chloe {
    struct CHLOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLOE>(arg0, 6, b"CHLOE", b"Side Eyeing Chloe", b"Chloe Clem (born November 30, 2010), commonly known by her Internet nickname \"Side Eyeing Chloe\", is an American Internet celebrity known for her concerned-looking reaction, which became a popular Internet meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9827_9343275110.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLOE>>(v1);
    }

    // decompiled from Move bytecode v6
}


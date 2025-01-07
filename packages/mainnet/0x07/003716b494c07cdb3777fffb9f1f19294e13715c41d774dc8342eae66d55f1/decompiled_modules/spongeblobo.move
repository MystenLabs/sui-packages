module 0x7003716b494c07cdb3777fffb9f1f19294e13715c41d774dc8342eae66d55f1::spongeblobo {
    struct SPONGEBLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBLOBO>(arg0, 6, b"SPONGEBLOBO", b"SpongeBlobo", b"In the depths of Bikini Bottom, something absorbently strange has emergeda fusion of SpongeBobs bubbly optimism and the blobfishs gelatinous charm. Introducing $SPONGEBLOBO, the token thats as unpredictable as the deep sea and as hilarious as a pineapple under the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14_54e13c1d2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBLOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBLOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xe22900d68bd6f3497c2d8fad0cddcd834e92b0586f3046858e1fc071572300b::boho {
    struct BOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOHO>(arg0, 6, b"Boho", b"In honor of Boho", b"This meme is in honor of Sui coolest NFT collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ih14fa_PG_400x400_4f4ae1d44c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}


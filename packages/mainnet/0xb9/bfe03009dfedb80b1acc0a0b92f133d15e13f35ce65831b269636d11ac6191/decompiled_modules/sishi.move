module 0xb9bfe03009dfedb80b1acc0a0b92f133d15e13f35ce65831b269636d11ac6191::sishi {
    struct SISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISHI>(arg0, 6, b"SISHI", b"SUISHIBA", b"A playful fusion of Shiba Inu charm and sushi delight. A meme coin that's both fun and flavorful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_23_29_21_94fb9d11f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


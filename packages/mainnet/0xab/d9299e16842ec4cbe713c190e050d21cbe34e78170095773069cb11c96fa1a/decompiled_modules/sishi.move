module 0xabd9299e16842ec4cbe713c190e050d21cbe34e78170095773069cb11c96fa1a::sishi {
    struct SISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISHI>(arg0, 6, b"SISHI", b"SUISHIBA", b"A playful fusion of Shiba Inu charm and sushi delight. A meme coin that's both fun and flavorful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fphoto_2024_10_17_23_29_21_94fb9d11f6.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SISHI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SISHI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISHI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


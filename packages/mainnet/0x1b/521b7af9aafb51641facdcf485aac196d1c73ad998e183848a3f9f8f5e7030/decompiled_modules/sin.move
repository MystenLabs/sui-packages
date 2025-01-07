module 0x1b521b7af9aafb51641facdcf485aac196d1c73ad998e183848a3f9f8f5e7030::sin {
    struct SIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIN>(arg0, 6, b"Sin", b"suibitcoin", b"Sui Bitcoin (SIN) is a community-driven meme coin that's serious about having fun! Built on SuiChain's cutting-edge technology, SIN brings lightning-fast transactions, enhanced security, and scalability to the meme coin universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_22_at_20_31_19_8c093593_2fdc410944.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


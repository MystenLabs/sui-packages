module 0x7141d68952f11e5f784cbfa20c0623086649cdc8de0ee04f9e8b3000638b3b7::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"BLUBIA", b"BLUBIA SUI", b"Behold the Queen of the Ocean Sui $BLUBIA, the ruler of cryptocurrencies with a nautical bent at Sui Network. She is graceful and attractive, ready to give her love and warmth to only one king. Her nautical magic will take you across oceans and make the moon accessible!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_3ff374fa90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd70ea9c430c643d59ddf14024ea002935cdc0874c1bdbb9d9dabff8bb0cfc63e::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 9, b"WOJAK", b"WOJAK", b"The classic Wojak meme brought to SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.kym-cdn.com/photos/images/newsfeed/001/749/973/f9e.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOJAK>(&mut v2, 6942080085000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}


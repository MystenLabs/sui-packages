module 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::meme_coin {
    struct MEME_COIN has drop {
        dummy_field: bool,
    }

    struct MemePublishedEvent has copy, drop {
        metadata_id: 0x2::object::ID,
        decimals: u8,
        symbol: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    fun init(arg0: MEME_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_COIN>(arg0, 9, b"MEME", b"Meme Coin", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wwww.meme.com")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<MEME_COIN>>(&v2),
            decimals    : 0x2::coin::get_decimals<MEME_COIN>(&v2),
            symbol      : 0x2::coin::get_symbol<MEME_COIN>(&v2),
            name        : 0x2::coin::get_name<MEME_COIN>(&v2),
            description : 0x2::coin::get_description<MEME_COIN>(&v2),
            icon_url    : 0x2::coin::get_icon_url<MEME_COIN>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}


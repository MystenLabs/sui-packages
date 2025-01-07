module 0xe985510609afd491306bc9d3e79c6e1cb68e668dec931a9c5e7a9c26a847d5e8::tghs {
    struct TGHS has drop {
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

    fun init(arg0: TGHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGHS>(arg0, 9, b"TGHS", b"ffha", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/846438d36d094c318048b82401bf13f8.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TGHS>>(&v2),
            decimals    : 0x2::coin::get_decimals<TGHS>(&v2),
            symbol      : 0x2::coin::get_symbol<TGHS>(&v2),
            name        : 0x2::coin::get_name<TGHS>(&v2),
            description : 0x2::coin::get_description<TGHS>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TGHS>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGHS>>(v2);
    }

    // decompiled from Move bytecode v6
}


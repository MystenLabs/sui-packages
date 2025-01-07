module 0xa54e40decfff7b331fa1b26a6e2d88cbfb874e48b4603e9982b681e447628e9::tood {
    struct TOOD has drop {
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

    fun init(arg0: TOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOD>(arg0, 9, b"TOOD", b"VvvvV", x"e58f91e79a84", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wwww.meme.com")), arg1);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg1);
        let v4 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TOOD>>(&v2),
            decimals    : 0x2::coin::get_decimals<TOOD>(&v2),
            symbol      : 0x2::coin::get_symbol<TOOD>(&v2),
            name        : 0x2::coin::get_name<TOOD>(&v2),
            description : 0x2::coin::get_description<TOOD>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TOOD>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOD>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOOD>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}


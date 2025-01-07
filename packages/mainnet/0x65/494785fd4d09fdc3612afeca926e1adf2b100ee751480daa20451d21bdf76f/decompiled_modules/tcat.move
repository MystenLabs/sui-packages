module 0x65494785fd4d09fdc3612afeca926e1adf2b100ee751480daa20451d21bdf76f::tcat {
    struct TCAT has drop {
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

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 9, b"TCAT", b"NAMCAT", b"https://www.iconfont.cn/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/6e83ce6e821842e9b747ace56e66a75d.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TCAT>>(&v2),
            decimals    : 0x2::coin::get_decimals<TCAT>(&v2),
            symbol      : 0x2::coin::get_symbol<TCAT>(&v2),
            name        : 0x2::coin::get_name<TCAT>(&v2),
            description : 0x2::coin::get_description<TCAT>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TCAT>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCAT>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0x5bb49237aa86523f7581d5e34488c875af15b055a650560ea93a24fa455e59ef::flj {
    struct FLJ has drop {
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

    fun init(arg0: FLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLJ>(arg0, 9, b"FLJ", b"FuLiJi", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/92c8c2b77d694f83a87e9c37fb6f9922.jpeg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<FLJ>>(&v2),
            decimals    : 0x2::coin::get_decimals<FLJ>(&v2),
            symbol      : 0x2::coin::get_symbol<FLJ>(&v2),
            name        : 0x2::coin::get_name<FLJ>(&v2),
            description : 0x2::coin::get_description<FLJ>(&v2),
            icon_url    : 0x2::coin::get_icon_url<FLJ>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLJ>>(v2);
    }

    // decompiled from Move bytecode v6
}


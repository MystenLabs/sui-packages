module 0x7e4e87132473fa15bfee70994256a878bfb831efae3e8a00a6745ee1f18001d1::sadd {
    struct SADD has drop {
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

    fun init(arg0: SADD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADD>(arg0, 9, b"SADD", b"ADSSS", b"sdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/ebb60155fe3540639d26f7937e86a45e.jpeg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<SADD>>(&v2),
            decimals    : 0x2::coin::get_decimals<SADD>(&v2),
            symbol      : 0x2::coin::get_symbol<SADD>(&v2),
            name        : 0x2::coin::get_name<SADD>(&v2),
            description : 0x2::coin::get_description<SADD>(&v2),
            icon_url    : 0x2::coin::get_icon_url<SADD>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADD>>(v2);
    }

    // decompiled from Move bytecode v6
}


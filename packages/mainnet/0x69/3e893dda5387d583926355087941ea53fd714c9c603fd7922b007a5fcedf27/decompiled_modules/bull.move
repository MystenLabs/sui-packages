module 0x693e893dda5387d583926355087941ea53fd714c9c603fd7922b007a5fcedf27::bull {
    struct BULL has drop {
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

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 9, b"BULL", b"trump bull", b"trump golden bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/a8641ebcecb74d09b3141065462c6809.jpeg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<BULL>>(&v2),
            decimals    : 0x2::coin::get_decimals<BULL>(&v2),
            symbol      : 0x2::coin::get_symbol<BULL>(&v2),
            name        : 0x2::coin::get_name<BULL>(&v2),
            description : 0x2::coin::get_description<BULL>(&v2),
            icon_url    : 0x2::coin::get_icon_url<BULL>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v2);
    }

    // decompiled from Move bytecode v6
}


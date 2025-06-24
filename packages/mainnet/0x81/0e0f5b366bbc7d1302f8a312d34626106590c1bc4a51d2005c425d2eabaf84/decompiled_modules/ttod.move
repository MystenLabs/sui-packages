module 0x810e0f5b366bbc7d1302f8a312d34626106590c1bc4a51d2005c425d2eabaf84::ttod {
    struct TTOD has drop {
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

    fun init(arg0: TTOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTOD>(arg0, 9, b"TTOD", b"TOOD", b"big man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/547226c178ce42d3b1a9c60c1cb02122.jpg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TTOD>>(&v2),
            decimals    : 0x2::coin::get_decimals<TTOD>(&v2),
            symbol      : 0x2::coin::get_symbol<TTOD>(&v2),
            name        : 0x2::coin::get_name<TTOD>(&v2),
            description : 0x2::coin::get_description<TTOD>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TTOD>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTOD>>(v2);
    }

    // decompiled from Move bytecode v6
}


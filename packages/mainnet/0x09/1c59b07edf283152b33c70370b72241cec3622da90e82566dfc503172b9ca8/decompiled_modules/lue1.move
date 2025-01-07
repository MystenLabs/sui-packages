module 0x91c59b07edf283152b33c70370b72241cec3622da90e82566dfc503172b9ca8::lue1 {
    struct LUE1 has drop {
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

    fun init(arg0: LUE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUE1>(arg0, 9, b"LUE1", b"sss", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/64087520261d4a03bac6651bf15514ab.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LUE1>>(&v2),
            decimals    : 0x2::coin::get_decimals<LUE1>(&v2),
            symbol      : 0x2::coin::get_symbol<LUE1>(&v2),
            name        : 0x2::coin::get_name<LUE1>(&v2),
            description : 0x2::coin::get_description<LUE1>(&v2),
            icon_url    : 0x2::coin::get_icon_url<LUE1>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUE1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUE1>>(v2);
    }

    // decompiled from Move bytecode v6
}


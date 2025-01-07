module 0x3ac438368244a63fdb94791f610a34c6838712589a1fa4ebfe1a5eb7bea0d4a7::fuck {
    struct FUCK has drop {
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

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 9, b"FUCK", b"VvvvV", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://15.165.42.164:8015/file/839c32f9a3d948299244e29ecb2677dd.jpeg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<FUCK>>(&v2),
            decimals    : 0x2::coin::get_decimals<FUCK>(&v2),
            symbol      : 0x2::coin::get_symbol<FUCK>(&v2),
            name        : 0x2::coin::get_name<FUCK>(&v2),
            description : 0x2::coin::get_description<FUCK>(&v2),
            icon_url    : 0x2::coin::get_icon_url<FUCK>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCK>>(v2);
    }

    // decompiled from Move bytecode v6
}


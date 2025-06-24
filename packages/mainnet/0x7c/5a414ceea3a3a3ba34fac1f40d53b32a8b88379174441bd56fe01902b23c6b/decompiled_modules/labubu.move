module 0x7c5a414ceea3a3a3ba34fac1f40d53b32a8b88379174441bd56fe01902b23c6b::labubu {
    struct LABUBU has drop {
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

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 9, b"LABUBU", b"labubu", b"Labubu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/d044e662dade4175be8decc9e818a72c.jpeg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LABUBU>>(&v2),
            decimals    : 0x2::coin::get_decimals<LABUBU>(&v2),
            symbol      : 0x2::coin::get_symbol<LABUBU>(&v2),
            name        : 0x2::coin::get_name<LABUBU>(&v2),
            description : 0x2::coin::get_description<LABUBU>(&v2),
            icon_url    : 0x2::coin::get_icon_url<LABUBU>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBU>>(v2);
    }

    // decompiled from Move bytecode v6
}


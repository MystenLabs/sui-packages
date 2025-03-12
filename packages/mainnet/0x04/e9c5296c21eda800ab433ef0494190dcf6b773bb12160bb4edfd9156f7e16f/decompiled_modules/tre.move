module 0x4e9c5296c21eda800ab433ef0494190dcf6b773bb12160bb4edfd9156f7e16f::tre {
    struct TRE has drop {
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

    fun init(arg0: TRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRE>(arg0, 9, b"TRE", b"NAMM", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/3a1c6b7e10e04898af1017a0054572a0.jpg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TRE>>(&v2),
            decimals    : 0x2::coin::get_decimals<TRE>(&v2),
            symbol      : 0x2::coin::get_symbol<TRE>(&v2),
            name        : 0x2::coin::get_name<TRE>(&v2),
            description : 0x2::coin::get_description<TRE>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TRE>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRE>>(v2);
    }

    // decompiled from Move bytecode v6
}


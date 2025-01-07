module 0x73d3e0530355408bd8745a8ee3eba576809087aa665d3b1d55b7701c794c15c1::fuckyo {
    struct FUCKYO has drop {
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

    fun init(arg0: FUCKYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKYO>(arg0, 9, b"FUCKYO", b"fuck you", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/6aeb3ef068704580bd926b9fb22a877f.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<FUCKYO>>(&v2),
            decimals    : 0x2::coin::get_decimals<FUCKYO>(&v2),
            symbol      : 0x2::coin::get_symbol<FUCKYO>(&v2),
            name        : 0x2::coin::get_name<FUCKYO>(&v2),
            description : 0x2::coin::get_description<FUCKYO>(&v2),
            icon_url    : 0x2::coin::get_icon_url<FUCKYO>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKYO>>(v2);
    }

    // decompiled from Move bytecode v6
}


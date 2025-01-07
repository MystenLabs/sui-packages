module 0x9bec1dc84a1beec58237cc9f241de0199e109e3c39dc82302dd023829aeebebe::asd {
    struct ASD has drop {
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

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 9, b"ASD", b"hugo", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/d28900243bf14e3686b112a23e1ce291.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<ASD>>(&v2),
            decimals    : 0x2::coin::get_decimals<ASD>(&v2),
            symbol      : 0x2::coin::get_symbol<ASD>(&v2),
            name        : 0x2::coin::get_name<ASD>(&v2),
            description : 0x2::coin::get_description<ASD>(&v2),
            icon_url    : 0x2::coin::get_icon_url<ASD>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASD>>(v2);
    }

    // decompiled from Move bytecode v6
}


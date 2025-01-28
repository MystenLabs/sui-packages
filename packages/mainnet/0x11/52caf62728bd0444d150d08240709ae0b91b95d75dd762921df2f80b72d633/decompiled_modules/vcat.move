module 0x1152caf62728bd0444d150d08240709ae0b91b95d75dd762921df2f80b72d633::vcat {
    struct VCAT has drop {
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

    fun init(arg0: VCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCAT>(arg0, 9, b"VCAT", b"Veggie Cat", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/029a1b2e472741a0be876ab8ba03e383.jpeg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<VCAT>>(&v2),
            decimals    : 0x2::coin::get_decimals<VCAT>(&v2),
            symbol      : 0x2::coin::get_symbol<VCAT>(&v2),
            name        : 0x2::coin::get_name<VCAT>(&v2),
            description : 0x2::coin::get_description<VCAT>(&v2),
            icon_url    : 0x2::coin::get_icon_url<VCAT>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCAT>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0x376f033de1ee934dcda48b4faa8e6ca0dc42ecd55cc78677f5904427b3924d4b::lh {
    struct LH has drop {
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

    fun init(arg0: LH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LH>(arg0, 9, b"LH", b"Meme Coin", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/a978d0bd4e8c4a5f8a3121b37af9e762.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LH>>(&v2),
            decimals    : 0x2::coin::get_decimals<LH>(&v2),
            symbol      : 0x2::coin::get_symbol<LH>(&v2),
            name        : 0x2::coin::get_name<LH>(&v2),
            description : 0x2::coin::get_description<LH>(&v2),
            icon_url    : 0x2::coin::get_icon_url<LH>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LH>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0x7b3606d21ef27b528247ad741317f985e09cb4ba9d9afd878aee0506e739c37::trtt {
    struct TRTT has drop {
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

    fun init(arg0: TRTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRTT>(arg0, 9, b"TRTT", b"TrTT", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/0c7b7a68261f4007afb4e77de4d4d491.jpg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TRTT>>(&v2),
            decimals    : 0x2::coin::get_decimals<TRTT>(&v2),
            symbol      : 0x2::coin::get_symbol<TRTT>(&v2),
            name        : 0x2::coin::get_name<TRTT>(&v2),
            description : 0x2::coin::get_description<TRTT>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TRTT>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRTT>>(v2);
    }

    // decompiled from Move bytecode v6
}


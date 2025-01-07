module 0xdb6ea10ac1b8a78b5c8d8f1eb5c4d4aaf7aabc1f56c9b07c22440669e2909ffe::fuckme {
    struct FUCKME has drop {
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

    fun init(arg0: FUCKME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKME>(arg0, 9, b"FUCKME", b"Tood", b"fuck me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/5929ed72c70a4ba68a9316ed91f592f7.jpg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<FUCKME>>(&v2),
            decimals    : 0x2::coin::get_decimals<FUCKME>(&v2),
            symbol      : 0x2::coin::get_symbol<FUCKME>(&v2),
            name        : 0x2::coin::get_name<FUCKME>(&v2),
            description : 0x2::coin::get_description<FUCKME>(&v2),
            icon_url    : 0x2::coin::get_icon_url<FUCKME>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKME>>(v2);
    }

    // decompiled from Move bytecode v6
}


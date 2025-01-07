module 0xd5efca4a83833eb220afb930e2f6ca55b78cd17715e3fc17a74e4b2d4c1d2dde::elza {
    struct ELZA has drop {
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

    fun init(arg0: ELZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELZA>(arg0, 9, b"ELZA", b"Elzaza", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://15.165.42.164:8015/file/ef409ec30fab4b79b2b27f5c06168426.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<ELZA>>(&v2),
            decimals    : 0x2::coin::get_decimals<ELZA>(&v2),
            symbol      : 0x2::coin::get_symbol<ELZA>(&v2),
            name        : 0x2::coin::get_name<ELZA>(&v2),
            description : 0x2::coin::get_description<ELZA>(&v2),
            icon_url    : 0x2::coin::get_icon_url<ELZA>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELZA>>(v2);
    }

    // decompiled from Move bytecode v6
}


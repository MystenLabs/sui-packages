module 0x903308e52cf9c55c7959c535ed7b132e0e3be67c38574e32d79e867a0e308c10::sdfg {
    struct SDFG has drop {
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

    fun init(arg0: SDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFG>(arg0, 9, b"SDFG", b"TTTT", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/696b2cfdadf24ffaaf66ec8614e2778e.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<SDFG>>(&v2),
            decimals    : 0x2::coin::get_decimals<SDFG>(&v2),
            symbol      : 0x2::coin::get_symbol<SDFG>(&v2),
            name        : 0x2::coin::get_name<SDFG>(&v2),
            description : 0x2::coin::get_description<SDFG>(&v2),
            icon_url    : 0x2::coin::get_icon_url<SDFG>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFG>>(v2);
    }

    // decompiled from Move bytecode v6
}


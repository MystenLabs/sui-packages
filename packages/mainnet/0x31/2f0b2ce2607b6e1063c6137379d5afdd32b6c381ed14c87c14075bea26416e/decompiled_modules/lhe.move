module 0x312f0b2ce2607b6e1063c6137379d5afdd32b6c381ed14c87c14075bea26416e::lhe {
    struct LHE has drop {
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

    fun init(arg0: LHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LHE>(arg0, 9, b"LHE", b"little he", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/97fe1c38733d45e6a763b55d6195db0e.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LHE>>(&v2),
            decimals    : 0x2::coin::get_decimals<LHE>(&v2),
            symbol      : 0x2::coin::get_symbol<LHE>(&v2),
            name        : 0x2::coin::get_name<LHE>(&v2),
            description : 0x2::coin::get_description<LHE>(&v2),
            icon_url    : 0x2::coin::get_icon_url<LHE>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LHE>>(v2);
    }

    // decompiled from Move bytecode v6
}


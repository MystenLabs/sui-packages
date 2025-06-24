module 0x3436715552b4a7a798a5658361918ceefec17a37ac2bd62e5e458952a30ef981::sbbbb {
    struct SBBBB has drop {
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

    fun init(arg0: SBBBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBBBB>(arg0, 9, b"SBBBB", b"sbbbb", b"asdddddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wwww.meme.com")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<SBBBB>>(&v2),
            decimals    : 0x2::coin::get_decimals<SBBBB>(&v2),
            symbol      : 0x2::coin::get_symbol<SBBBB>(&v2),
            name        : 0x2::coin::get_name<SBBBB>(&v2),
            description : 0x2::coin::get_description<SBBBB>(&v2),
            icon_url    : 0x2::coin::get_icon_url<SBBBB>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBBBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBBBB>>(v2);
    }

    // decompiled from Move bytecode v6
}


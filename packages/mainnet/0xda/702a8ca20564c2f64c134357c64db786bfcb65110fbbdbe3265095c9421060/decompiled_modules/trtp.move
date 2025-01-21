module 0xda702a8ca20564c2f64c134357c64db786bfcb65110fbbdbe3265095c9421060::trtp {
    struct TRTP has drop {
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

    fun init(arg0: TRTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRTP>(arg0, 9, b"TRTP", b"Trump2025", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/48a8aee19fe54dad97fa6b9248ab058d.jpg")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TRTP>>(&v2),
            decimals    : 0x2::coin::get_decimals<TRTP>(&v2),
            symbol      : 0x2::coin::get_symbol<TRTP>(&v2),
            name        : 0x2::coin::get_name<TRTP>(&v2),
            description : 0x2::coin::get_description<TRTP>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TRTP>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRTP>>(v2);
    }

    // decompiled from Move bytecode v6
}


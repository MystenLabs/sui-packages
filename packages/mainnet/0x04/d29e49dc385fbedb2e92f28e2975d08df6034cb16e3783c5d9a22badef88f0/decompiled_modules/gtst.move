module 0x4d29e49dc385fbedb2e92f28e2975d08df6034cb16e3783c5d9a22badef88f0::gtst {
    struct GTST has drop {
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

    fun init(arg0: GTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTST>(arg0, 9, b"GTST", b"123fff", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waterpump.fun/api/file/cddc918f13084d1d9cda4703e0ff6a6c.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<GTST>>(&v2),
            decimals    : 0x2::coin::get_decimals<GTST>(&v2),
            symbol      : 0x2::coin::get_symbol<GTST>(&v2),
            name        : 0x2::coin::get_name<GTST>(&v2),
            description : 0x2::coin::get_description<GTST>(&v2),
            icon_url    : 0x2::coin::get_icon_url<GTST>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTST>>(v2);
    }

    // decompiled from Move bytecode v6
}


module 0x2b58a8e9f2ffcb010cc4546fa541b113398dbc85a96292ab7944f5edbf65d116::asdd {
    struct ASDD has drop {
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

    fun init(arg0: ASDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDD>(arg0, 9, b"ASDD", b"asdddas", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://15.165.42.164:8015/file/e8cd92918af04f948b328d293a20c3bd.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<ASDD>>(&v2),
            decimals    : 0x2::coin::get_decimals<ASDD>(&v2),
            symbol      : 0x2::coin::get_symbol<ASDD>(&v2),
            name        : 0x2::coin::get_name<ASDD>(&v2),
            description : 0x2::coin::get_description<ASDD>(&v2),
            icon_url    : 0x2::coin::get_icon_url<ASDD>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDD>>(v2);
    }

    // decompiled from Move bytecode v6
}


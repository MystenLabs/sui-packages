module 0xe6b13718292599324394a3d62fa265a6640d5bef315048b36c837b1db9e6be52::tst2 {
    struct TST2 has drop {
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

    fun init(arg0: TST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST2>(arg0, 9, b"TST2", b"TestAAA2", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wwww.meme.com")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TST2>>(&v2),
            decimals    : 0x2::coin::get_decimals<TST2>(&v2),
            symbol      : 0x2::coin::get_symbol<TST2>(&v2),
            name        : 0x2::coin::get_name<TST2>(&v2),
            description : 0x2::coin::get_description<TST2>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TST2>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST2>>(v2);
    }

    // decompiled from Move bytecode v6
}


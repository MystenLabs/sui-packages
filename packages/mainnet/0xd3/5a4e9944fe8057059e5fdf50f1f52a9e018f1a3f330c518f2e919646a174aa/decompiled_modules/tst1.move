module 0xd35a4e9944fe8057059e5fdf50f1f52a9e018f1a3f330c518f2e919646a174aa::tst1 {
    struct TST1 has drop {
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

    fun init(arg0: TST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST1>(arg0, 9, b"TST1", b"Meme Coin", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wwww.meme.com")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TST1>>(&v2),
            decimals    : 0x2::coin::get_decimals<TST1>(&v2),
            symbol      : 0x2::coin::get_symbol<TST1>(&v2),
            name        : 0x2::coin::get_name<TST1>(&v2),
            description : 0x2::coin::get_description<TST1>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TST1>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST1>>(v2);
    }

    // decompiled from Move bytecode v6
}


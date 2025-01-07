module 0xaac7f5c885287234906c2a4a8accc1db200b51883091d1b7beeec71da9ce8efb::tst {
    struct TST has drop {
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

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"TST", b"TestAAA", b"Meme Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://15.165.42.164:8015/file/43f83f1275694537905c61a11e1c38fc.png")), arg1);
        let v2 = v1;
        let v3 = MemePublishedEvent{
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TST>>(&v2),
            decimals    : 0x2::coin::get_decimals<TST>(&v2),
            symbol      : 0x2::coin::get_symbol<TST>(&v2),
            name        : 0x2::coin::get_name<TST>(&v2),
            description : 0x2::coin::get_description<TST>(&v2),
            icon_url    : 0x2::coin::get_icon_url<TST>(&v2),
        };
        0x2::event::emit<MemePublishedEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST>>(v2);
    }

    // decompiled from Move bytecode v6
}


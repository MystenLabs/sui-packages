module 0x6386ca445c82895d7b2d29fbd3a823b85e600f20428059244341d8b342383dde::bandwagon {
    struct BANDWAGON has drop {
        dummy_field: bool,
    }

    public(friend) fun create_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(arg0))
    }

    fun init(arg0: BANDWAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDWAGON>(arg0, 9, b"BANDWAGON", b"Bandwagon Token", b"Happy Birthday Eric!", 0x1::option::some<0x2::url::Url>(create_url(b"https://scontent.xx.fbcdn.net/v/t1.15752-9/467487678_1347969902860559_885532184497658803_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=0024fc&_nc_ohc=u5m21Ao36L8Q7kNvgEz7vKS&_nc_zt=23&_nc_ht=scontent.xx&oh=03_Q7cD1gE88cQx4XT6ZuXPfIB6CnrtR8CR0w0JeNqMiQ5FdVAPCw&oe=67A533C0")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BANDWAGON>>(0x2::coin::mint<BANDWAGON>(&mut v2, 69, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANDWAGON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDWAGON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


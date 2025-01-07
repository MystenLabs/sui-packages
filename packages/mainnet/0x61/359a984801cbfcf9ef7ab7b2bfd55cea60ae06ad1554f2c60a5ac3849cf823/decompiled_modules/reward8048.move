module 0x61359a984801cbfcf9ef7ab7b2bfd55cea60ae06ad1554f2c60a5ac3849cf823::reward8048 {
    struct REWARD8048 has drop {
        dummy_field: bool,
    }

    struct TICKET_8048 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        Reward: 0x1::string::String,
    }

    public fun DistributeReward8048(arg0: &mut vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(arg0) > 0) {
            let v0 = TICKET_8048{
                id          : 0x2::object::new(arg1),
                name        : 0x1::string::utf8(b"Frostyswap Membership Card"),
                image_url   : 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_f5c51456c56044e8bf61024e6fffb311~mv2.jpg"),
                description : 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."),
                Reward      : 0x1::string::utf8(b"5,000 SUI"),
            };
            let v1 = MintEvent{
                nft_id      : 0x2::object::id<TICKET_8048>(&v0),
                user        : 0x2::tx_context::sender(arg1),
                name        : 0x1::string::utf8(b"Frostyswap Membership Card"),
                image_url   : 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_f5c51456c56044e8bf61024e6fffb311~mv2.jpg"),
                description : 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."),
                Reward      : 0x1::string::utf8(b"5,000 SUI"),
            };
            0x2::event::emit<MintEvent>(v1);
            0x2::transfer::public_transfer<TICKET_8048>(v0, 0x1::vector::pop_back<address>(arg0));
        };
    }

    fun init(arg0: REWARD8048, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Reward"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Reward Voucher"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://static.wixstatic.com/media/33e670_f5c51456c56044e8bf61024e6fffb311~mv2.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Frostyswap, Trade and Earn in our DeFi platform."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://frostyfi.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Frostyswap"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"5,000 SUI"));
        let v4 = 0x2::package::claim<REWARD8048>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TICKET_8048>(&v4, v0, v2, arg1);
        0x2::display::update_version<TICKET_8048>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TICKET_8048>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::merch {
    struct MERCH has drop {
        dummy_field: bool,
    }

    struct Merch has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        merch_type: 0x1::string::String,
    }

    struct MerchMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mint_limit: u64,
        mint_count: u64,
    }

    struct MerchMintedEvent has copy, drop {
        id: 0x2::object::ID,
        game_id: 0x1::string::String,
        sender: address,
    }

    fun init(arg0: MERCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MERCH>(arg0, arg1);
        let v1 = MerchMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Merchandise"),
            mint_limit  : 0,
            mint_count  : 0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"merch_type"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{merch_type}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Official Panzerdogs Merch"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://QmW8ntcWMUuG5CvF1wvqzm6qn2M5xxdP4zzxMxMiwLLrBW/{merch_type}/{game_id}.gif"));
        let v6 = 0x2::display::new_with_fields<Merch>(&v0, v2, v4, arg1);
        0x2::display::update_version<Merch>(&mut v6);
        0x2::transfer::public_transfer<MerchMintAuth>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Merch>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Merch>(arg0), 1);
        let v0 = MerchMintAuth{
            id          : 0x2::object::new(arg3),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Merchandise"),
            mint_limit  : arg1,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<MerchMintAuth>(v0, arg2);
    }

    public fun mint_ptb(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut MerchMintAuth, arg4: &mut 0x2::tx_context::TxContext) : Merch {
        if (arg3.mint_limit > 0) {
            assert!(arg3.mint_count < arg3.mint_limit, 2);
        };
        let v0 = Merch{
            id         : 0x2::object::new(arg4),
            game_id    : arg0,
            name       : arg1,
            merch_type : arg2,
        };
        arg3.mint_count = arg3.mint_count + 1;
        let v1 = MerchMintedEvent{
            id      : 0x2::object::id<Merch>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MerchMintedEvent>(v1);
        v0
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut MerchMintAuth, arg5: &mut 0x2::tx_context::TxContext) {
        0x1::debug::print<u64>(&arg4.mint_limit);
        0x1::debug::print<u64>(&arg4.mint_count);
        if (arg4.mint_limit > 0) {
            assert!(arg4.mint_count < arg4.mint_limit, 2);
        };
        let v0 = Merch{
            id         : 0x2::object::new(arg5),
            game_id    : arg0,
            name       : arg1,
            merch_type : arg2,
        };
        arg4.mint_count = arg4.mint_count + 1;
        let v1 = MerchMintedEvent{
            id      : 0x2::object::id<Merch>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MerchMintedEvent>(v1);
        0x2::transfer::public_transfer<Merch>(v0, arg3);
    }

    public(friend) fun mint_to_address_pkg(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Merch{
            id         : 0x2::object::new(arg4),
            game_id    : arg0,
            name       : arg1,
            merch_type : arg2,
        };
        let v1 = MerchMintedEvent{
            id      : 0x2::object::id<Merch>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MerchMintedEvent>(v1);
        0x2::transfer::public_transfer<Merch>(v0, arg3);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<Merch>) {
        assert!(0x2::package::from_package<Merch>(arg0), 1);
        0x2::display::edit<Merch>(arg3, arg1, arg2);
        0x2::display::update_version<Merch>(arg3);
    }

    public(friend) fun uid_mut(arg0: &mut Merch) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}


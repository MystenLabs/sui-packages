module 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::tankparts {
    struct TANKPARTS has drop {
        dummy_field: bool,
    }

    struct TankPart has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        part_type: 0x1::string::String,
        rarity: 0x1::string::String,
        manufacturer: 0x1::string::String,
        tier: u64,
    }

    struct TankPartsMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mint_limit: u64,
        mint_count: u64,
    }

    struct TankPartMintedEvent has copy, drop {
        id: 0x2::object::ID,
        game_id: 0x1::string::String,
        sender: address,
    }

    fun init(arg0: TANKPARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TANKPARTS>(arg0, arg1);
        let v1 = TankPartsMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Tank Parts"),
            mint_limit  : 0,
            mint_count  : 0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"part_type"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{part_type}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Tank Part used to construct a tank in Panzerdogs"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://QmUpi7ftTgqQ4QMq4uDcgV322J68wEJEdAqdeSuFzkbZtR/{part_type}/{game_id}.png"));
        let v6 = 0x2::display::new_with_fields<TankPart>(&v0, v2, v4, arg1);
        0x2::display::update_version<TankPart>(&mut v6);
        0x2::transfer::public_transfer<TankPartsMintAuth>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TankPart>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<TankPart>(arg0), 1);
        let v0 = TankPartsMintAuth{
            id          : 0x2::object::new(arg3),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Tank Parts"),
            mint_limit  : arg1,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<TankPartsMintAuth>(v0, arg2);
    }

    public fun mint_ptb(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut TankPartsMintAuth, arg7: &mut 0x2::tx_context::TxContext) : TankPart {
        if (arg6.mint_limit > 0) {
            assert!(arg6.mint_count < arg6.mint_limit, 2);
        };
        let v0 = TankPart{
            id           : 0x2::object::new(arg7),
            game_id      : arg0,
            name         : arg1,
            part_type    : arg2,
            rarity       : arg3,
            manufacturer : arg4,
            tier         : arg5,
        };
        arg6.mint_count = arg6.mint_count + 1;
        let v1 = TankPartMintedEvent{
            id      : 0x2::object::id<TankPart>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<TankPartMintedEvent>(v1);
        v0
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: &mut TankPartsMintAuth, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7.mint_limit > 0) {
            assert!(arg7.mint_count < arg7.mint_limit, 2);
        };
        let v0 = TankPart{
            id           : 0x2::object::new(arg8),
            game_id      : arg0,
            name         : arg1,
            part_type    : arg2,
            rarity       : arg3,
            manufacturer : arg4,
            tier         : arg5,
        };
        arg7.mint_count = arg7.mint_count + 1;
        let v1 = TankPartMintedEvent{
            id      : 0x2::object::id<TankPart>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<TankPartMintedEvent>(v1);
        0x2::transfer::public_transfer<TankPart>(v0, arg6);
    }

    public(friend) fun mint_to_address_pkg(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = TankPart{
            id           : 0x2::object::new(arg7),
            game_id      : arg0,
            name         : arg1,
            part_type    : arg2,
            rarity       : arg3,
            manufacturer : arg4,
            tier         : arg5,
        };
        let v1 = TankPartMintedEvent{
            id      : 0x2::object::id<TankPart>(&v0),
            game_id : arg0,
            sender  : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<TankPartMintedEvent>(v1);
        0x2::transfer::public_transfer<TankPart>(v0, arg6);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<TankPart>) {
        assert!(0x2::package::from_package<TankPart>(arg0), 1);
        0x2::display::edit<TankPart>(arg3, arg1, arg2);
        0x2::display::update_version<TankPart>(arg3);
    }

    public(friend) fun uid_mut(arg0: &mut TankPart) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}


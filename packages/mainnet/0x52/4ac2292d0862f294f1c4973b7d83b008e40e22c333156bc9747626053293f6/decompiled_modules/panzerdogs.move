module 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::panzerdogs {
    struct PANZERDOGS has drop {
        dummy_field: bool,
    }

    struct Panzerdog has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        clan: 0x1::string::String,
        dog_type: 0x1::string::String,
        image_hash: 0x1::string::String,
        tier: u64,
    }

    struct PanzerdogsMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mint_limit: u64,
        mint_count: u64,
    }

    struct PanzerdogMintedEvent has copy, drop {
        id: 0x2::object::ID,
        clan: 0x1::string::String,
        sender: address,
    }

    public(friend) fun image_hash(arg0: &Panzerdog) : 0x1::string::String {
        arg0.image_hash
    }

    fun init(arg0: PANZERDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PANZERDOGS>(arg0, arg1);
        let v1 = PanzerdogsMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs"),
            mint_limit  : 0,
            mint_count  : 0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://{image_hash}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A fierce companion in battle within Panzerdogs."));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v6 = 0x2::display::new_with_fields<Panzerdog>(&v0, v2, v4, arg1);
        0x2::display::update_version<Panzerdog>(&mut v6);
        0x2::transfer::public_transfer<PanzerdogsMintAuth>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Panzerdog>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Panzerdog>(arg0), 1);
        let v0 = PanzerdogsMintAuth{
            id          : 0x2::object::new(arg3),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs"),
            mint_limit  : arg1,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<PanzerdogsMintAuth>(v0, arg2);
    }

    public fun mint_ptb(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut PanzerdogsMintAuth, arg6: &mut 0x2::tx_context::TxContext) : Panzerdog {
        if (arg5.mint_limit > 0) {
            assert!(arg5.mint_count < arg5.mint_limit, 2);
        };
        let v0 = Panzerdog{
            id         : 0x2::object::new(arg6),
            name       : arg0,
            clan       : arg1,
            dog_type   : arg2,
            image_hash : arg3,
            tier       : arg4,
        };
        arg5.mint_count = arg5.mint_count + 1;
        let v1 = PanzerdogMintedEvent{
            id     : 0x2::object::id<Panzerdog>(&v0),
            clan   : arg1,
            sender : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PanzerdogMintedEvent>(v1);
        v0
    }

    public entry fun mint_to_address(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut PanzerdogsMintAuth, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6.mint_limit > 0) {
            assert!(arg6.mint_count < arg6.mint_limit, 2);
        };
        let v0 = Panzerdog{
            id         : 0x2::object::new(arg7),
            name       : arg0,
            clan       : arg1,
            dog_type   : arg2,
            image_hash : arg3,
            tier       : arg4,
        };
        arg6.mint_count = arg6.mint_count + 1;
        let v1 = PanzerdogMintedEvent{
            id     : 0x2::object::id<Panzerdog>(&v0),
            clan   : arg1,
            sender : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<PanzerdogMintedEvent>(v1);
        0x2::transfer::public_transfer<Panzerdog>(v0, arg5);
    }

    public(friend) fun mint_to_address_pkg(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Panzerdog{
            id         : 0x2::object::new(arg6),
            name       : arg0,
            clan       : arg1,
            dog_type   : arg2,
            image_hash : arg3,
            tier       : arg4,
        };
        let v1 = PanzerdogMintedEvent{
            id     : 0x2::object::id<Panzerdog>(&v0),
            clan   : arg1,
            sender : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PanzerdogMintedEvent>(v1);
        0x2::transfer::public_transfer<Panzerdog>(v0, arg5);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<Panzerdog>) {
        assert!(0x2::package::from_package<Panzerdog>(arg0), 1);
        0x2::display::edit<Panzerdog>(arg3, arg1, arg2);
        0x2::display::update_version<Panzerdog>(arg3);
    }

    public(friend) fun mutate_image_hash(arg0: &mut Panzerdog, arg1: 0x1::string::String) {
        arg0.image_hash = arg1;
    }

    public(friend) fun uid_mut(arg0: &mut Panzerdog) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}


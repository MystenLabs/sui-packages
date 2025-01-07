module 0x524ac2292d0862f294f1c4973b7d83b008e40e22c333156bc9747626053293f6::cyberpills {
    struct CYBERPILLS has drop {
        dummy_field: bool,
    }

    struct Cyberpill has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct CyberpillsMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mint_limit: u64,
        mint_count: u64,
    }

    struct CyberpillMintedEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct CyberpillAmountChangedEvent has copy, drop {
        id: 0x2::object::ID,
        mint_auth: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    public entry fun destroy_empty(arg0: Cyberpill) {
        let Cyberpill {
            id     : v0,
            amount : v1,
        } = arg0;
        assert!(v1 == 0, 3);
        0x2::object::delete(v0);
    }

    public entry fun add_to_existing(arg0: u64, arg1: &mut Cyberpill, arg2: &mut CyberpillsMintAuth, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2.mint_limit > 0) {
            assert!(arg2.mint_count + arg0 <= arg2.mint_limit, 2);
        };
        arg1.amount = arg1.amount + arg0;
        arg2.mint_count = arg2.mint_count + arg0;
        let v0 = CyberpillAmountChangedEvent{
            id        : 0x2::object::id<Cyberpill>(arg1),
            mint_auth : 0x2::object::id<CyberpillsMintAuth>(arg2),
            amount    : arg0,
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CyberpillAmountChangedEvent>(v0);
    }

    fun init(arg0: CYBERPILLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CYBERPILLS>(arg0, arg1);
        let v1 = CyberpillsMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Cyberpills"),
            mint_limit  : 0,
            mint_count  : 0,
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Cyberpill"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Can be used to create a Cyberdog in Panzerdogs."));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://QmZdcLXk1zvLAYCEsXBX8pZyimThWVGMscSnrBbbB154xd/cyberpill.gif"));
        let v6 = 0x2::display::new_with_fields<Cyberpill>(&v0, v2, v4, arg1);
        0x2::display::update_version<Cyberpill>(&mut v6);
        0x2::transfer::public_transfer<CyberpillsMintAuth>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Cyberpill>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut Cyberpill, arg1: &mut Cyberpill) {
        arg0.amount = arg0.amount + arg1.amount;
        arg1.amount = 0;
    }

    public entry fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Cyberpill>(arg0), 1);
        let v0 = CyberpillsMintAuth{
            id          : 0x2::object::new(arg3),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Cyberpills"),
            mint_limit  : arg1,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<CyberpillsMintAuth>(v0, arg2);
    }

    public fun mint_ptb(arg0: u64, arg1: &mut CyberpillsMintAuth, arg2: &mut 0x2::tx_context::TxContext) : Cyberpill {
        if (arg1.mint_limit > 0) {
            assert!(arg1.mint_count + arg0 <= arg1.mint_limit, 2);
        };
        let v0 = Cyberpill{
            id     : 0x2::object::new(arg2),
            amount : arg0,
        };
        arg1.mint_count = arg1.mint_count + arg0;
        let v1 = CyberpillMintedEvent{
            id     : 0x2::object::id<Cyberpill>(&v0),
            amount : arg0,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CyberpillMintedEvent>(v1);
        v0
    }

    public entry fun mint_to_address(arg0: u64, arg1: address, arg2: &mut CyberpillsMintAuth, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2.mint_limit > 0) {
            assert!(arg2.mint_count + arg0 <= arg2.mint_limit, 2);
        };
        let v0 = Cyberpill{
            id     : 0x2::object::new(arg3),
            amount : arg0,
        };
        arg2.mint_count = arg2.mint_count + arg0;
        let v1 = CyberpillMintedEvent{
            id     : 0x2::object::id<Cyberpill>(&v0),
            amount : arg0,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CyberpillMintedEvent>(v1);
        0x2::transfer::public_transfer<Cyberpill>(v0, arg1);
    }

    public(friend) fun mint_to_address_pkg(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Cyberpill{
            id     : 0x2::object::new(arg2),
            amount : arg0,
        };
        let v1 = CyberpillMintedEvent{
            id     : 0x2::object::id<Cyberpill>(&v0),
            amount : arg0,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CyberpillMintedEvent>(v1);
        0x2::transfer::public_transfer<Cyberpill>(v0, arg1);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<Cyberpill>) {
        assert!(0x2::package::from_package<Cyberpill>(arg0), 1);
        0x2::display::edit<Cyberpill>(arg3, arg1, arg2);
        0x2::display::update_version<Cyberpill>(arg3);
    }

    public(friend) fun uid_mut(arg0: &mut Cyberpill) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}


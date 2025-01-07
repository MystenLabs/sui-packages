module 0xd5f526c55e0d4c8a5869f2d93ac739c9cb142f19d7cdbe0f6d317a4325b6f0f8::art {
    struct ShibaSuiAI has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Global has key {
        id: 0x2::object::UID,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
        number_nfts: u64,
        public_phase: bool,
        whitelist_mint_price: u64,
        public_mint_price: u64,
    }

    struct CollectionOwnerCapability has key {
        id: 0x2::object::UID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &ShibaSuiAI) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: &mut Global, arg1: ShibaSuiAI) {
        arg0.number_nfts = arg0.number_nfts - 1;
        let ShibaSuiAI {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun collect_profits(arg0: &CollectionOwnerCapability, arg1: &mut Global, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun description(arg0: &ShibaSuiAI) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                   : 0x2::object::new(arg0),
            profits              : 0x2::balance::zero<0x2::sui::SUI>(),
            number_nfts          : 0,
            public_phase         : false,
            whitelist_mint_price : 1000000000,
            public_mint_price    : 3000000000,
        };
        0x2::transfer::share_object<Global>(v0);
        let v1 = CollectionOwnerCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CollectionOwnerCapability>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_phase(arg0: &Global) : bool {
        arg0.public_phase
    }

    public fun name(arg0: &ShibaSuiAI) : &0x1::string::String {
        &arg0.name
    }

    public fun number_nfts(arg0: &Global) : u64 {
        arg0.number_nfts
    }

    public fun profits(arg0: &Global) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.profits)
    }

    public entry fun public_mint(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.public_mint_price, 0);
        assert!(arg0.number_nfts < 5000, 2);
        assert!(arg0.public_phase, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profits, v0);
        arg0.number_nfts = arg0.number_nfts + 1;
        let v1 = ShibaSuiAI{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v2,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v3);
        0x2::transfer::public_transfer<ShibaSuiAI>(v1, v2);
    }

    public fun public_mint_price(arg0: &Global) : u64 {
        arg0.public_mint_price
    }

    public entry fun update_description(arg0: &mut ShibaSuiAI, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_phase(arg0: &CollectionOwnerCapability, arg1: &mut Global) {
        arg1.public_phase = !arg1.public_phase;
    }

    public entry fun whitelist_mint(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.whitelist_mint_price, 0);
        assert!(arg0.number_nfts < 5000, 2);
        assert!(!arg0.public_phase, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.profits, v0);
        arg0.number_nfts = arg0.number_nfts + 1;
        let v1 = ShibaSuiAI{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v2,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v3);
        0x2::transfer::public_transfer<ShibaSuiAI>(v1, v2);
    }

    public fun whitelist_mint_price(arg0: &Global) : u64 {
        arg0.whitelist_mint_price
    }

    // decompiled from Move bytecode v6
}


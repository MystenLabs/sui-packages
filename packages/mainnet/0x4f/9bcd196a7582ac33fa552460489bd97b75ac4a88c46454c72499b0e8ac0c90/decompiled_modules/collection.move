module 0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::collection {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        supply: u64,
        url: 0x2::url::Url,
        metadata_uri: 0x1::string::String,
        minted: u64,
        max_free_mint_per_wallet: u64,
        max_whitelist_per_wallet: u64,
        whitelist_price: u64,
        max_public_per_wallet: u64,
        public_price: u64,
        launchpad_fee: u64,
        creator: address,
        admin: address,
    }

    public fun addFreeMintAddress(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<address>(&mut arg0.id, 0x2::tx_context::sender(arg1))) {
            let v0 = 0x2::dynamic_object_field::remove<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1));
            assert!(v0.count + 1 <= arg0.max_free_mint_per_wallet, 0);
            v0.count = v0.count + 1;
            0x2::dynamic_object_field::add<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1), v0);
        } else {
            let v1 = Ticket{
                id    : 0x2::object::new(arg1),
                count : 1,
            };
            0x2::dynamic_object_field::add<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1), v1);
        };
    }

    public fun addWhitelistAddress(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<address>(&mut arg0.id, 0x2::tx_context::sender(arg1))) {
            let v0 = 0x2::dynamic_object_field::remove<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1));
            assert!(v0.count + 1 <= arg0.max_free_mint_per_wallet + arg0.max_whitelist_per_wallet, 0);
            v0.count = v0.count + 1;
            0x2::dynamic_object_field::add<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1), v0);
        } else {
            let v1 = Ticket{
                id    : 0x2::object::new(arg1),
                count : 1,
            };
            0x2::dynamic_object_field::add<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1), v1);
        };
    }

    public entry fun changeCollectionDescription(arg0: 0x1::string::String, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.description = arg0;
    }

    public entry fun changeCollectionName(arg0: 0x1::string::String, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.name = arg0;
    }

    public entry fun changeCollectionSupply(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.supply = arg0;
    }

    public entry fun changeUrl(arg0: vector<u8>, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x4f9bcd196a7582ac33fa552460489bd97b75ac4a88c46454c72499b0e8ac0c90::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg0);
    }

    public fun getAdmin(arg0: &mut Collection) : address {
        arg0.admin
    }

    public fun getCollectionDescription(arg0: &mut Collection) : 0x1::string::String {
        arg0.description
    }

    public fun getCollectionName(arg0: &mut Collection) : 0x1::string::String {
        arg0.name
    }

    public fun getCollectionSupply(arg0: &mut Collection) : u64 {
        arg0.supply
    }

    public fun getCreator(arg0: &mut Collection) : address {
        arg0.creator
    }

    public fun getLaunchpadFee(arg0: &mut Collection) : u64 {
        arg0.launchpad_fee
    }

    public fun getMaxFreeMintPerWallet(arg0: &mut Collection) : u64 {
        arg0.max_free_mint_per_wallet
    }

    public fun getMaxPublicPerWallet(arg0: &mut Collection) : u64 {
        arg0.max_public_per_wallet
    }

    public fun getMaxWhitelistPerWallet(arg0: &mut Collection) : u64 {
        arg0.max_whitelist_per_wallet
    }

    public fun getMetaDataUri(arg0: &mut Collection) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun getMinted(arg0: &mut Collection) : u64 {
        arg0.minted
    }

    public fun getPublicPrice(arg0: &mut Collection) : u64 {
        arg0.public_price
    }

    public fun getWhiteListPrice(arg0: &mut Collection) : u64 {
        arg0.whitelist_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id                       : 0x2::object::new(arg0),
            name                     : 0x1::string::utf8(b"Sui Cats"),
            description              : 0x1::string::utf8(b"Sui Cats is a limited collection on Sui Network, with their accessibility-oriented design, the Cats goal is to invade the blockchain and spread their community."),
            supply                   : 3333,
            url                      : 0x2::url::new_unsafe_from_bytes(b"https://bettasui.xyz/collection/26/profile.png"),
            metadata_uri             : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmebQcFnJGyL9j1XzKb2BhRpLrhzbft39ugzvVVDuJzpXC/sui cats"),
            minted                   : 0,
            max_free_mint_per_wallet : 2,
            max_whitelist_per_wallet : 3,
            whitelist_price          : 7000000000,
            max_public_per_wallet    : 3333,
            public_price             : 14000000000,
            launchpad_fee            : 3,
            creator                  : @0xe8db0f89f61872ff29bee1550e1b36f9582665d4e6457777f95297d73e5215d3,
            admin                    : @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500,
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    public fun inscreaseMinted(arg0: &mut Collection) {
        arg0.minted = arg0.minted + 1;
    }

    // decompiled from Move bytecode v6
}


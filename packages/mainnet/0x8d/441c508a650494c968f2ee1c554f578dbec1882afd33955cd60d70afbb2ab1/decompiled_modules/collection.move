module 0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::collection {
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
        max_mint_per_whitelist: u64,
        whitelist_price: u64,
        max_public_per_wallet: u64,
        public_price: u64,
        launchpad_fee: u64,
        creator: address,
        admin: address,
    }

    public fun addWhitelistAddress(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<address>(&mut arg0.id, 0x2::tx_context::sender(arg1))) {
            let v0 = 0x2::dynamic_object_field::remove<address, Ticket>(&mut arg0.id, 0x2::tx_context::sender(arg1));
            assert!(v0.count + 1 <= arg0.max_mint_per_whitelist, 0);
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
        0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.description = arg0;
    }

    public entry fun changeCollectionName(arg0: 0x1::string::String, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.name = arg0;
    }

    public entry fun changeCollectionSupply(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
        arg1.supply = arg0;
    }

    public entry fun changeUrl(arg0: vector<u8>, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        0x8d441c508a650494c968f2ee1c554f578dbec1882afd33955cd60d70afbb2ab1::admin::is_admin(arg1.admin, 0x2::tx_context::sender(arg2));
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

    public fun getMaxPublicPerWallet(arg0: &mut Collection) : u64 {
        arg0.max_public_per_wallet
    }

    public fun getMaxWhitelistPerWallet(arg0: &mut Collection) : u64 {
        arg0.max_mint_per_whitelist
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
            id                     : 0x2::object::new(arg0),
            name                   : 0x1::string::utf8(b"Suisafari"),
            description            : 0x1::string::utf8(b"Join the wild adventure of @Suisafari and explore the untamed frontier of @SuiNetwork! | P2E Ecosystem | 7 Species, 7 Planets"),
            supply                 : 1035,
            url                    : 0x2::url::new_unsafe_from_bytes(b"https://bettasui.xyz/collection/37/profile.png"),
            metadata_uri           : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmUQZ5zPn2jxuQWfJbBUGZgQqn785jJTPfyVSN1pMKYNdk/Suisafari"),
            minted                 : 0,
            max_mint_per_whitelist : 3,
            whitelist_price        : 9000000000,
            max_public_per_wallet  : 1035,
            public_price           : 14000000000,
            launchpad_fee          : 3,
            creator                : @0x4df25da4b5a9fbdfe3c052947aca64cc42d23a19841b1844933b3a53d3ec470c,
            admin                  : @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500,
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    public fun inscreaseMinted(arg0: &mut Collection) {
        arg0.minted = arg0.minted + 1;
    }

    // decompiled from Move bytecode v6
}


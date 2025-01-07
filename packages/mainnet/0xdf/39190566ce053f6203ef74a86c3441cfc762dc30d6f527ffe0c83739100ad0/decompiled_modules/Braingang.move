module 0xdf39190566ce053f6203ef74a86c3441cfc762dc30d6f527ffe0c83739100ad0::Braingang {
    struct Braingang has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NFTGlobalData has key {
        id: 0x2::object::UID,
        maxSupply: u64,
        mintedSupply: u64,
        royaltyPercent: u64,
        startingPrice: u64,
        mintingEnabled: bool,
        owner: address,
        mintedAddresses: vector<address>,
    }

    struct Ownership has key {
        id: 0x2::object::UID,
    }

    struct BraingangMinted has copy, drop {
        braingang_id: 0x2::object::ID,
        minted_by: address,
    }

    entry fun addTrait(arg0: &mut Braingang, arg1: &mut NFTGlobalData, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.traits = arg2;
    }

    entry fun changeMintingStatus(arg0: &mut NFTGlobalData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.mintingEnabled = !arg0.mintingEnabled;
    }

    entry fun changeRoyaltyPercent(arg0: u64, arg1: &mut NFTGlobalData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 0);
        arg1.royaltyPercent = arg0;
    }

    entry fun changeStartingPrice(arg0: u64, arg1: &mut NFTGlobalData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 0);
        arg1.startingPrice = arg0;
    }

    entry fun destroy(arg0: Braingang) {
        let Braingang {
            id     : v0,
            name   : _,
            traits : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ownership{id: 0x2::object::new(arg0)};
        let v1 = NFTGlobalData{
            id              : 0x2::object::new(arg0),
            maxSupply       : 25,
            mintedSupply    : 0,
            royaltyPercent  : 5,
            startingPrice   : 1,
            mintingEnabled  : true,
            owner           : 0x2::tx_context::sender(arg0),
            mintedAddresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<NFTGlobalData>(v1);
        0x2::transfer::transfer<Ownership>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun mintBraingang(arg0: &mut NFTGlobalData, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mintingEnabled, 0);
        assert!(arg0.mintedSupply < arg0.maxSupply, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Braingang{
            id     : 0x2::object::new(arg4),
            name   : 0x1::string::utf8(arg1),
            traits : 0x1::string::utf8(arg2),
            url    : 0x1::string::utf8(arg3),
        };
        let v2 = BraingangMinted{
            braingang_id : 0x2::object::uid_to_inner(&v1.id),
            minted_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BraingangMinted>(v2);
        arg0.mintedSupply = arg0.mintedSupply + 1;
        arg0.startingPrice = arg0.startingPrice / 3 * 2;
        0x1::vector::push_back<address>(&mut arg0.mintedAddresses, v0);
        0x2::transfer::transfer<Braingang>(v1, v0);
    }

    public fun name(arg0: &Braingang) : &0x1::string::String {
        &arg0.name
    }

    entry fun setUrl(arg0: &mut Braingang, arg1: &mut NFTGlobalData, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.url = arg2;
    }

    public fun traits(arg0: &Braingang) : &0x1::string::String {
        &arg0.traits
    }

    entry fun transferBraingang(arg0: Braingang, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Braingang>(arg0, arg1);
    }

    public fun url(arg0: &Braingang) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}


module 0xcead8a6c2544146499e0ac09a257445c8f433a918c66c4bac1b278284a9f2904::seed_nft {
    struct SeedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
        owner: address,
        referal: address,
        royalty_address: address,
        price: u128,
        target_price: u128,
        auction_expire_datetime: u128,
        transfer_count: u64,
        caretors: vector<Creator>,
        bids: vector<Bid>,
    }

    struct Creator has drop, store {
        creator_address: address,
        share: u64,
    }

    struct Bid has drop, store {
        bidder: address,
        price: u128,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
    }

    struct List<T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        nft: T0,
        price: u64,
        last_offer_id: u64,
    }

    public fun transfer(arg0: SeedNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SeedNFT>(arg0, arg1);
    }

    public fun url(arg0: &SeedNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: SeedNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SeedNFT {
            id                      : v0,
            name                    : _,
            description             : _,
            url                     : _,
            nft_url                 : _,
            owner                   : _,
            referal                 : _,
            royalty_address         : _,
            price                   : _,
            target_price            : _,
            auction_expire_datetime : _,
            transfer_count          : _,
            caretors                : _,
            bids                    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun description(arg0: &SeedNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = List<T0>{
            id            : 0x2::object::new(arg3),
            seller        : 0x2::tx_context::sender(arg3),
            nft           : arg1,
            price         : arg2,
            last_offer_id : 0,
        };
        0x2::dynamic_field::add<0x2::object::ID, List<T0>>(&mut arg0.id, 0x2::object::id<T0>(&arg1), v0);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: address, arg6: address, arg7: u128, arg8: u128, arg9: u128, arg10: u64, arg11: vector<Creator>, arg12: vector<Bid>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = SeedNFT{
            id                      : 0x2::object::new(arg13),
            name                    : 0x1::string::utf8(arg0),
            description             : 0x1::string::utf8(arg1),
            url                     : 0x2::url::new_unsafe_from_bytes(arg2),
            nft_url                 : 0x2::url::new_unsafe_from_bytes(arg3),
            owner                   : arg4,
            referal                 : arg5,
            royalty_address         : arg6,
            price                   : arg7,
            target_price            : arg8,
            auction_expire_datetime : arg9,
            transfer_count          : arg10,
            caretors                : arg11,
            bids                    : arg12,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SeedNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SeedNFT>(v1, v0);
    }

    public fun name(arg0: &SeedNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_url(arg0: &SeedNFT) : &0x2::url::Url {
        &arg0.nft_url
    }

    public entry fun unlist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let List {
            id            : v0,
            seller        : v1,
            nft           : v2,
            price         : _,
            last_offer_id : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, List<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v1, 126);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v2, v1);
    }

    public fun update_description(arg0: &mut SeedNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}


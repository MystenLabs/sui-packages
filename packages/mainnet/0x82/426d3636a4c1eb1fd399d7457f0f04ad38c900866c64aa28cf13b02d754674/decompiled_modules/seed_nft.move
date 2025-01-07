module 0x82426d3636a4c1eb1fd399d7457f0f04ad38c900866c64aa28cf13b02d754674::seed_nft {
    struct SeedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
        owner: address,
        referal: address,
        royalty_address: address,
        price: u64,
        target_price: u64,
        auction_expire_datetime: u64,
        transfer_count: u64,
        caretors: vector<Creator>,
        highest_bid: Bid,
    }

    struct Creator has drop, store {
        creator_address: address,
        creator_share: u64,
    }

    struct Bid has store {
        bidder: address,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
    }

    public entry fun create_marketplace(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Marketplace>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: vector<address>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg9) == 0x1::vector::length<u64>(&arg10), 2001);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = Bid{
            bidder  : v0,
            price   : 0,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = 0x1::vector::empty<Creator>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg9)) {
            let v4 = Creator{
                creator_address : *0x1::vector::borrow<address>(&arg9, v3),
                creator_share   : *0x1::vector::borrow<u64>(&arg10, v3),
            };
            0x1::vector::push_back<Creator>(&mut v2, v4);
            v3 = v3 + 1;
        };
        let v5 = SeedNFT{
            id                      : 0x2::object::new(arg11),
            name                    : 0x1::string::utf8(arg0),
            description             : 0x1::string::utf8(arg1),
            url                     : 0x2::url::new_unsafe_from_bytes(arg2),
            nft_url                 : 0x2::url::new_unsafe_from_bytes(arg3),
            owner                   : v0,
            referal                 : arg4,
            royalty_address         : arg5,
            price                   : arg6,
            target_price            : arg7,
            auction_expire_datetime : arg8,
            transfer_count          : 0,
            caretors                : v2,
            highest_bid             : v1,
        };
        let v6 = NFTMinted{
            object_id : 0x2::object::id<SeedNFT>(&v5),
            creator   : v0,
            name      : v5.name,
        };
        0x2::event::emit<NFTMinted>(v6);
        0x2::transfer::public_transfer<SeedNFT>(v5, v0);
    }

    // decompiled from Move bytecode v6
}


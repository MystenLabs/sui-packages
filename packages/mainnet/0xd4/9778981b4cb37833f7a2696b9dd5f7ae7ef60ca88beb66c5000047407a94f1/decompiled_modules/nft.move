module 0xd49778981b4cb37833f7a2696b9dd5f7ae7ef60ca88beb66c5000047407a94f1::nft {
    struct MintEntry has store {
        addr: address,
        counter: u8,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        entries: vector<MintEntry>,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        logo_uri: 0x1::string::String,
        price: u64,
        whitelist_price: u64,
        royalty_percent: u64,
        royalty_address: address,
        beneficiary: address,
        max_per_wallet: u8,
        whitelist: vector<address>,
    }

    struct DevNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Root has store, key {
        id: 0x2::object::UID,
        collection: CollectionInfo,
        caps: MintCap,
    }

    public entry fun init_root(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: u8, arg10: vector<address>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionInfo{
            id              : 0x2::object::new(arg11),
            name            : 0x1::string::utf8(arg0),
            symbol          : 0x1::string::utf8(arg1),
            metadata_uri    : 0x1::string::utf8(arg2),
            logo_uri        : 0x1::string::utf8(arg3),
            price           : arg4,
            whitelist_price : arg5,
            royalty_percent : arg6,
            royalty_address : arg7,
            beneficiary     : arg8,
            max_per_wallet  : arg9,
            whitelist       : arg10,
        };
        let v1 = MintCap{
            id      : 0x2::object::new(arg11),
            entries : 0x1::vector::empty<MintEntry>(),
        };
        let v2 = Root{
            id         : 0x2::object::new(arg11),
            collection : v0,
            caps       : v1,
        };
        0x2::transfer::public_share_object<Root>(v2);
    }

    public entry fun mint_to_sender(arg0: &mut Root, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &arg0.collection;
        let v2 = &mut arg0.caps;
        let v3 = v1.price;
        if (!0x1::vector::is_empty<address>(&v1.whitelist)) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&v1.whitelist)) {
                if (*0x1::vector::borrow<address>(&v1.whitelist, v4) == v0) {
                    v3 = v1.whitelist_price;
                    break
                };
                v4 = v4 + 1;
            };
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg5), v1.beneficiary);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v5 = false;
        let v6 = 0;
        while (v6 < 0x1::vector::length<MintEntry>(&v2.entries)) {
            let v7 = 0x1::vector::borrow_mut<MintEntry>(&mut v2.entries, v6);
            if (v7.addr == v0) {
                let v8 = v7.counter + 1;
                assert!(v8 <= v1.max_per_wallet, 3);
                v7.counter = v8;
                v5 = true;
                break
            };
            v6 = v6 + 1;
        };
        if (!v5) {
            assert!(v1.max_per_wallet > 0, 4);
            let v9 = MintEntry{
                addr    : v0,
                counter : 1,
            };
            0x1::vector::push_back<MintEntry>(&mut v2.entries, v9);
        };
        let v10 = DevNetNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v11 = MintNFTEvent{
            object_id : 0x2::object::id<DevNetNFT>(&v10),
            creator   : v0,
            name      : v10.name,
        };
        0x2::event::emit<MintNFTEvent>(v11);
        0x2::transfer::public_transfer<DevNetNFT>(v10, v0);
    }

    // decompiled from Move bytecode v6
}


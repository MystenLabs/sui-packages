module 0xab0f23e621a603cff1f4bfcba0864c42120eec2287f1e9be64f6c8be58b0fb40::nft {
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

    public entry fun init_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: u8, arg10: vector<address>, arg11: &mut 0x2::tx_context::TxContext) {
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
        0x2::transfer::public_transfer<CollectionInfo>(v0, 0x2::tx_context::sender(arg11));
        let v1 = MintCap{
            id      : 0x2::object::new(arg11),
            entries : 0x1::vector::empty<MintEntry>(),
        };
        0x2::transfer::public_transfer<MintCap>(v1, 0x2::tx_context::sender(arg11));
    }

    public entry fun mint_to_sender(arg0: &CollectionInfo, arg1: &mut MintCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.price;
        let v2 = false;
        if (!0x1::vector::is_empty<address>(&arg0.whitelist)) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg0.whitelist)) {
                if (*0x1::vector::borrow<address>(&arg0.whitelist, v3) == v0) {
                    v1 = arg0.whitelist_price;
                    v2 = true;
                    break
                };
                v3 = v3 + 1;
            };
            assert!(v2, 1);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg6), arg0.beneficiary);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v4 = false;
        let v5 = 0;
        while (v5 < 0x1::vector::length<MintEntry>(&arg1.entries)) {
            let v6 = 0x1::vector::borrow_mut<MintEntry>(&mut arg1.entries, v5);
            if (v6.addr == v0) {
                let v7 = v6.counter + 1;
                assert!(v7 <= arg0.max_per_wallet, 3);
                v6.counter = v7;
                v4 = true;
                break
            };
            v5 = v5 + 1;
        };
        if (!v4) {
            assert!(arg0.max_per_wallet > 0, 4);
            let v8 = MintEntry{
                addr    : v0,
                counter : 1,
            };
            0x1::vector::push_back<MintEntry>(&mut arg1.entries, v8);
        };
        let v9 = DevNetNFT{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg4),
            url         : 0x2::url::new_unsafe_from_bytes(arg5),
        };
        let v10 = MintNFTEvent{
            object_id : 0x2::object::id<DevNetNFT>(&v9),
            creator   : v0,
            name      : v9.name,
        };
        0x2::event::emit<MintNFTEvent>(v10);
        0x2::transfer::public_transfer<DevNetNFT>(v9, v0);
    }

    // decompiled from Move bytecode v6
}


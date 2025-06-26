module 0x1373bc7bf2b3fefbbd07e744f148307695325e6ba54341dc071d3221dcfb41c8::nft {
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

    public entry fun init_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionInfo{
            id             : 0x2::object::new(arg7),
            name           : 0x1::string::utf8(arg0),
            symbol         : 0x1::string::utf8(arg1),
            metadata_uri   : 0x1::string::utf8(arg2),
            logo_uri       : 0x1::string::utf8(arg3),
            price          : arg4,
            max_per_wallet : arg5,
            whitelist      : arg6,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v0, 0x2::tx_context::sender(arg7));
        let v1 = MintCap{
            id      : 0x2::object::new(arg7),
            entries : 0x1::vector::empty<MintEntry>(),
        };
        0x2::transfer::public_transfer<MintCap>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun mint(arg0: &CollectionInfo, arg1: &mut MintCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (!0x1::vector::is_empty<address>(&arg0.whitelist)) {
            let v1 = false;
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg0.whitelist)) {
                if (*0x1::vector::borrow<address>(&arg0.whitelist, v2) == v0) {
                    v1 = true;
                };
                v2 = v2 + 1;
            };
            assert!(v1, 1);
        };
        let v3 = false;
        let v4 = 0;
        while (v4 < 0x1::vector::length<MintEntry>(&arg1.entries)) {
            let v5 = 0x1::vector::borrow_mut<MintEntry>(&mut arg1.entries, v4);
            if (v5.addr == v0) {
                let v6 = v5.counter + 1;
                assert!(v6 <= arg0.max_per_wallet, 2);
                v5.counter = v6;
                v3 = true;
            };
            v4 = v4 + 1;
        };
        if (!v3) {
            assert!(arg0.max_per_wallet > 0, 3);
            let v7 = MintEntry{
                addr    : v0,
                counter : 1,
            };
            0x1::vector::push_back<MintEntry>(&mut arg1.entries, v7);
        };
        let v8 = DevNetNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v9 = MintNFTEvent{
            object_id : 0x2::object::id<DevNetNFT>(&v8),
            creator   : v0,
            name      : v8.name,
        };
        0x2::event::emit<MintNFTEvent>(v9);
        0x2::transfer::public_transfer<DevNetNFT>(v8, v0);
    }

    // decompiled from Move bytecode v6
}


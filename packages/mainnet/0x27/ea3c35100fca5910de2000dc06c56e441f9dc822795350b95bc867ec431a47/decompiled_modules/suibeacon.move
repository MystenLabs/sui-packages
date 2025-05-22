module 0x27ea3c35100fca5910de2000dc06c56e441f9dc822795350b95bc867ec431a47::suibeacon {
    struct MemberNFT has store, key {
        id: 0x2::object::UID,
        user_address: address,
        project_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        join_date: u64,
        image_url: 0x1::string::String,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<address, bool>,
    }

    struct NFTMinted has copy, drop {
        recipient: address,
        user_address: 0x1::string::String,
        project_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id     : 0x2::object::new(arg0),
            minted : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Registry, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (0x2::table::contains<address, bool>(&arg3.minted, v0) && *0x2::table::borrow<address, bool>(&arg3.minted, v0)) {
            abort 1
        };
        if (0x2::table::contains<address, bool>(&arg3.minted, v0)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg3.minted, v0) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg3.minted, v0, true);
        };
        let v1 = 0x1::string::utf8(arg1);
        let v2 = 0x1::string::utf8(arg2);
        let v3 = 0x1::string::utf8(arg4);
        let v4 = MemberNFT{
            id           : 0x2::object::new(arg6),
            user_address : v0,
            project_name : v1,
            blob_id      : v2,
            join_date    : 0x2::clock::timestamp_ms(arg5),
            image_url    : v3,
        };
        0x2::transfer::public_transfer<MemberNFT>(v4, v0);
        let v5 = NFTMinted{
            recipient    : v0,
            user_address : 0x1::string::utf8(arg0),
            project_name : v1,
            blob_id      : v2,
            image_url    : v3,
        };
        0x2::event::emit<NFTMinted>(v5);
    }

    // decompiled from Move bytecode v6
}


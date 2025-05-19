module 0x85e4ed362d45f92c9b815a1a86c0e28034164ae0219f13f2a775a4342ddebad8::suibeacon {
    struct MemberNFT has store, key {
        id: 0x2::object::UID,
        user_address: address,
        project_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        join_date: u64,
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
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id     : 0x2::object::new(arg0),
            minted : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Registry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
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
        let v3 = MemberNFT{
            id           : 0x2::object::new(arg5),
            user_address : v0,
            project_name : v1,
            blob_id      : v2,
            join_date    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::public_transfer<MemberNFT>(v3, v0);
        let v4 = NFTMinted{
            recipient    : v0,
            user_address : 0x1::string::utf8(arg0),
            project_name : v1,
            blob_id      : v2,
        };
        0x2::event::emit<NFTMinted>(v4);
    }

    // decompiled from Move bytecode v6
}


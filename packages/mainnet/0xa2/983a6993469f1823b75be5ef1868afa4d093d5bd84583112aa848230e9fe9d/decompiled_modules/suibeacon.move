module 0xa2983a6993469f1823b75be5ef1868afa4d093d5bd84583112aa848230e9fe9d::suibeacon {
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
        minted: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        recipient: address,
        user_address: 0x1::string::String,
        project_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun get_mint_count(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.minted, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.minted, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id     : 0x2::object::new(arg0),
            minted : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Registry, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (0x2::table::contains<address, u64>(&arg3.minted, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg3.minted, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg3.minted, v0, 1);
        };
        let v2 = 0x1::string::utf8(arg1);
        let v3 = 0x1::string::utf8(arg2);
        let v4 = 0x1::string::utf8(arg4);
        let v5 = MemberNFT{
            id           : 0x2::object::new(arg6),
            user_address : v0,
            project_name : v2,
            blob_id      : v3,
            join_date    : 0x2::clock::timestamp_ms(arg5),
            image_url    : v4,
        };
        0x2::transfer::public_transfer<MemberNFT>(v5, v0);
        let v6 = NFTMinted{
            recipient    : v0,
            user_address : 0x1::string::utf8(arg0),
            project_name : v2,
            blob_id      : v3,
            image_url    : v4,
        };
        0x2::event::emit<NFTMinted>(v6);
    }

    // decompiled from Move bytecode v6
}


module 0x563a9f4d0a7bdc481e723a1e00f50eadd43fcb086e0ceac32518f1fc33335f9e::call_boy_nft {
    struct CallBoyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct CALL_BOY_NFT has drop {
        dummy_field: bool,
    }

    struct ModuleState has store, key {
        id: 0x2::object::UID,
        owner: address,
        mint_limits: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: CallBoyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CallBoyNFT>(arg0, arg1);
    }

    public fun url(arg0: &CallBoyNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: CallBoyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let CallBoyNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &CallBoyNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: CALL_BOY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://callboy-example-app.onrender.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Call Boys"));
        let v5 = 0x2::package::claim<CALL_BOY_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<CallBoyNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<CallBoyNFT>(&mut v6);
        let v7 = ModuleState{
            id          : 0x2::object::new(arg1),
            owner       : v0,
            mint_limits : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<ModuleState>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<CallBoyNFT>>(v6, v0);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : CallBoyNFT {
        let v0 = CallBoyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<CallBoyNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: &mut ModuleState, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, u64>(&arg0.mint_limits, v0)) {
            abort 1
        };
        let v1 = *0x2::table::borrow<address, u64>(&arg0.mint_limits, v0);
        if (v1 == 0) {
            abort 2
        };
        0x2::table::remove<address, u64>(&mut arg0.mint_limits, v0);
        0x2::table::add<address, u64>(&mut arg0.mint_limits, v0, v1 - 1);
        0x2::transfer::public_transfer<CallBoyNFT>(mint(arg1, arg2, arg3, arg4), v0);
    }

    public fun name(arg0: &CallBoyNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut CallBoyNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_mint_limits(arg0: &mut ModuleState, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != arg0.owner) {
            abort 3
        };
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 4);
        update_mint_limits_helper(arg0, &arg1, &arg2, 0, v0);
    }

    fun update_mint_limits_helper(arg0: &mut ModuleState, arg1: &vector<address>, arg2: &vector<u64>, arg3: u64, arg4: u64) {
        if (arg3 >= arg4) {
            return
        };
        let v0 = *0x1::vector::borrow<address>(arg1, arg3);
        if (0x2::table::contains<address, u64>(&arg0.mint_limits, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.mint_limits, v0);
        };
        0x2::table::add<address, u64>(&mut arg0.mint_limits, v0, *0x1::vector::borrow<u64>(arg2, arg3));
        update_mint_limits_helper(arg0, arg1, arg2, arg3 + 1, arg4);
    }

    // decompiled from Move bytecode v6
}


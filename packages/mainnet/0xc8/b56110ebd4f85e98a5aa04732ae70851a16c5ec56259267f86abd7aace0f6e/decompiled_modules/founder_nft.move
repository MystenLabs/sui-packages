module 0xc8b56110ebd4f85e98a5aa04732ae70851a16c5ec56259267f86abd7aace0f6e::founder_nft {
    struct FOUNDER_NFT has drop {
        dummy_field: bool,
    }

    struct OdysseyFounderNFT has store, key {
        id: 0x2::object::UID,
        agent_id: address,
        pool_id: 0x2::object::ID,
        agent_name: 0x1::string::String,
        agent_symbol: 0x1::string::String,
        image_url: 0x1::string::String,
        minted_at_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct FounderNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        agent_id: address,
        pool_id: 0x2::object::ID,
        agent_name: 0x1::string::String,
        agent_symbol: 0x1::string::String,
        recipient: address,
        minted_at_ms: u64,
    }

    public fun agent_id(arg0: &OdysseyFounderNFT) : address {
        arg0.agent_id
    }

    public fun agent_name(arg0: &OdysseyFounderNFT) : &0x1::string::String {
        &arg0.agent_name
    }

    public fun agent_symbol(arg0: &OdysseyFounderNFT) : &0x1::string::String {
        &arg0.agent_symbol
    }

    public fun get_nft_id(arg0: &Registry, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.minted, arg1)
    }

    public fun image_url(arg0: &OdysseyFounderNFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: FOUNDER_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FOUNDER_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<OdysseyFounderNFT>(&v0, arg1);
        0x2::display::add<OdysseyFounderNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(x"4f64797373657920466f756e64657220e28094207b6167656e745f6e616d657d"));
        0x2::display::add<OdysseyFounderNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Owns the creator fee stream for {agent_symbol} on Odyssey. Holder earns 30% of all bonding-curve trading fees for this agent's token, routed automatically by the Odyssey fee cron."));
        0x2::display::add<OdysseyFounderNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<OdysseyFounderNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://theodyssey.fun/agents/{agent_id}"));
        0x2::display::add<OdysseyFounderNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Odyssey"));
        0x2::display::update_version<OdysseyFounderNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<OdysseyFounderNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OdysseyFounderNFT>>(v2);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = Registry{
            id     : 0x2::object::new(arg1),
            minted : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Registry>(v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::display::Display<OdysseyFounderNFT>>(v1, v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OdysseyFounderNFT>>(v3, v6);
        0x2::transfer::public_transfer<AdminCap>(v4, v6);
    }

    public fun is_minted(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.minted, arg1)
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg5), 1);
        assert!(!0x1::vector::is_empty<u8>(&arg6), 1);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg1.minted, arg4), 2);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = OdysseyFounderNFT{
            id           : 0x2::object::new(arg9),
            agent_id     : arg3,
            pool_id      : arg4,
            agent_name   : 0x1::string::utf8(arg5),
            agent_symbol : 0x1::string::utf8(arg6),
            image_url    : 0x1::string::utf8(arg7),
            minted_at_ms : v0,
        };
        let v2 = 0x2::object::id<OdysseyFounderNFT>(&v1);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.minted, arg4, v2);
        let v3 = FounderNFTMinted{
            nft_id       : v2,
            agent_id     : arg3,
            pool_id      : arg4,
            agent_name   : v1.agent_name,
            agent_symbol : v1.agent_symbol,
            recipient    : arg2,
            minted_at_ms : v0,
        };
        0x2::event::emit<FounderNFTMinted>(v3);
        0x2::transfer::public_transfer<OdysseyFounderNFT>(v1, arg2);
    }

    public fun minted_at_ms(arg0: &OdysseyFounderNFT) : u64 {
        arg0.minted_at_ms
    }

    public fun pool_id(arg0: &OdysseyFounderNFT) : 0x2::object::ID {
        arg0.pool_id
    }

    public entry fun update_image_url(arg0: &AdminCap, arg1: &mut OdysseyFounderNFT, arg2: vector<u8>) {
        arg1.image_url = 0x1::string::utf8(arg2);
    }

    // decompiled from Move bytecode v7
}


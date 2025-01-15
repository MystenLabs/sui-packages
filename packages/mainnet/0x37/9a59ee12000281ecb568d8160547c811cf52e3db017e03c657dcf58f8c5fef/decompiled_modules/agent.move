module 0x379a59ee12000281ecb568d8160547c811cf52e3db017e03c657dcf58f8c5fef::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        validator: 0x1::option::Option<vector<u8>>,
        minting_fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AGENT_NFT has store, key {
        id: 0x2::object::UID,
        xid: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        user_nonce: 0x2::table::Table<address, u128>,
    }

    struct MintedEvent has copy, drop {
        user: address,
        id: 0x2::object::ID,
        xid: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct BurnedEvent has copy, drop {
        user: address,
        id: 0x2::object::ID,
        xid: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun burn(arg0: AGENT_NFT, arg1: &VaultConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1002);
        let AGENT_NFT {
            id          : v0,
            xid         : v1,
            name        : v2,
            description : v3,
        } = arg0;
        let v4 = v0;
        let v5 = BurnedEvent{
            user        : 0x2::tx_context::sender(arg2),
            id          : 0x2::object::uid_to_inner(&v4),
            xid         : v1,
            name        : v2,
            description : v3,
        };
        0x2::event::emit<BurnedEvent>(v5);
        0x2::object::delete(v4);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<AGENT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://storage.local/assets/{xid}/.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://storage.local/detail/{xid}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://x.com/5son"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"5SON"));
        let v6 = 0x2::display::new_with_fields<AGENT_NFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<AGENT_NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<AGENT_NFT>>(v6, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v0);
        let v8 = UserArchive{
            id         : 0x2::object::new(arg1),
            user_nonce : 0x2::table::new<address, u128>(arg1),
        };
        0x2::transfer::public_share_object<UserArchive>(v8);
        let v9 = VaultConfig{
            id          : 0x2::object::new(arg1),
            version     : 1,
            validator   : 0x1::option::none<vector<u8>>(),
            minting_fee : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<VaultConfig>(v9);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut VaultConfig) {
        assert!(arg1.version < 1, 1003);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut VaultConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut UserArchive, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AGENT_NFT {
        assert!(arg0.version == 1, 1002);
        verifySignature(arg2, arg3, &arg0.validator);
        let v0 = 0x2::bcs::new(arg3);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        assert!(0x2::tx_context::sender(arg6) == v1, 1006);
        assert!(0x2::bcs::peel_u64(&mut v0) > 0x2::clock::timestamp_ms(arg5), 1007);
        let v2 = if (0x2::table::contains<address, u128>(&arg4.user_nonce, v1)) {
            0x2::table::borrow_mut<address, u128>(&mut arg4.user_nonce, v1)
        } else {
            0x2::table::add<address, u128>(&mut arg4.user_nonce, v1, 0);
            0x2::table::borrow_mut<address, u128>(&mut arg4.user_nonce, v1)
        };
        assert!(*v2 < 0x2::bcs::peel_u128(&mut v0), 1008);
        *v2 = *v2 + 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 0x2::bcs::peel_u64(&mut v0), 1000);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.minting_fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = AGENT_NFT{
            id          : 0x2::object::new(arg6),
            xid         : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            name        : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            description : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
        };
        let v4 = MintedEvent{
            user        : 0x2::tx_context::sender(arg6),
            id          : 0x2::object::id<AGENT_NFT>(&v3),
            xid         : v3.xid,
            name        : v3.name,
            description : v3.description,
        };
        0x2::event::emit<MintedEvent>(v4);
        v3
    }

    public fun set_validator(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: vector<u8>) {
        assert!(arg1.version == 1, 1002);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg1.validator, arg2);
    }

    fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 1004);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 1005);
    }

    public fun withdraw_fee(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.version == 1, 1002);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.minting_fee, 0x2::balance::value<0x2::sui::SUI>(&arg1.minting_fee), arg2)
    }

    // decompiled from Move bytecode v6
}


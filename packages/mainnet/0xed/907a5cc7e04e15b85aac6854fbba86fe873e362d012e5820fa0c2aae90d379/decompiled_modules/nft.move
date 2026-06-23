module 0xed907a5cc7e04e15b85aac6854fbba86fe873e362d012e5820fa0c2aae90d379::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct NftToken has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        animation_url: 0x2::url::Url,
        metadata_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        creator: address,
    }

    struct AdminConfig has key {
        id: 0x2::object::UID,
        root_admin: address,
        admins: vector<address>,
        frozen: bool,
        mint_paused: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        name: 0x1::string::String,
    }

    struct NFTBurned has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct FreezeChanged has copy, drop {
        frozen: bool,
        admin: address,
    }

    struct AdminAdded has copy, drop {
        admin: address,
        added_by: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
        removed_by: address,
    }

    struct RootAdminTransferred has copy, drop {
        old_root_admin: address,
        new_root_admin: address,
    }

    struct MintPauseChanged has copy, drop {
        paused: bool,
        admin: address,
    }

    struct NFTFieldUpdated has copy, drop {
        object_id: 0x2::object::ID,
        admin: address,
        field: 0x1::string::String,
    }

    public fun add_admin(arg0: &mut AdminConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_root_admin(arg0, v0);
        assert_not_zero(arg1);
        assert!(!contains(&arg0.admins, arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v1 = AdminAdded{
            admin    : arg1,
            added_by : v0,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    public fun animation_url(arg0: &NftToken) : &0x2::url::Url {
        &arg0.animation_url
    }

    fun assert_admin(arg0: &AdminConfig, arg1: address) {
        assert!(contains(&arg0.admins, arg1), 1);
    }

    fun assert_admin_or_root(arg0: &AdminConfig, arg1: address) {
        assert!(arg0.root_admin == arg1 || contains(&arg0.admins, arg1), 1);
    }

    fun assert_bytes_len(arg0: &vector<u8>, arg1: u64) {
        assert!(0x1::vector::length<u8>(arg0) <= arg1, 8);
    }

    fun assert_not_zero(arg0: address) {
        assert!(arg0 != @0x0, 3);
    }

    fun assert_root_admin(arg0: &AdminConfig, arg1: address) {
        assert!(arg0.root_admin == arg1, 7);
    }

    public fun burn(arg0: NftToken, arg1: &mut 0x2::tx_context::TxContext) {
        let NftToken {
            id            : v0,
            name          : _,
            description   : _,
            image_url     : _,
            animation_url : _,
            metadata_url  : _,
            project_url   : _,
            creator       : _,
        } = arg0;
        0x2::object::delete(v0);
        let v8 = NFTBurned{
            object_id : 0x2::object::id<NftToken>(&arg0),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTBurned>(v8);
    }

    fun contains(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun creator(arg0: &NftToken) : address {
        arg0.creator
    }

    public fun description(arg0: &NftToken) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &NftToken) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"animation_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"metadata_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{animation_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x2::transfer::public_transfer<0x2::display::Display<NftToken>>(0x2::display::new_with_fields<NftToken>(&v0, v1, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminConfig{
            id          : 0x2::object::new(arg1),
            root_admin  : 0x2::tx_context::sender(arg1),
            admins      : v5,
            frozen      : false,
            mint_paused : false,
        };
        0x2::transfer::share_object<AdminConfig>(v6);
    }

    public fun is_admin(arg0: &AdminConfig, arg1: address) : bool {
        contains(&arg0.admins, arg1)
    }

    public fun is_frozen(arg0: &AdminConfig) : bool {
        arg0.frozen
    }

    public fun is_mint_paused(arg0: &AdminConfig) : bool {
        arg0.mint_paused
    }

    public fun metadata_url(arg0: &NftToken) : &0x2::url::Url {
        &arg0.metadata_url
    }

    public fun mint_to(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &AdminConfig, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert_admin(arg7, v0);
        assert!(!arg7.mint_paused, 9);
        assert_not_zero(arg6);
        assert_bytes_len(&arg0, 128);
        assert_bytes_len(&arg1, 1024);
        assert_bytes_len(&arg2, 2048);
        assert_bytes_len(&arg3, 2048);
        assert_bytes_len(&arg4, 2048);
        assert_bytes_len(&arg5, 2048);
        let v1 = NftToken{
            id            : 0x2::object::new(arg8),
            name          : 0x1::string::utf8(arg0),
            description   : 0x1::string::utf8(arg1),
            image_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            animation_url : 0x2::url::new_unsafe_from_bytes(arg3),
            metadata_url  : 0x2::url::new_unsafe_from_bytes(arg4),
            project_url   : 0x2::url::new_unsafe_from_bytes(arg5),
            creator       : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NftToken>(&v1),
            creator   : v0,
            recipient : arg6,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<NftToken>(v1, arg6);
    }

    public fun name(arg0: &NftToken) : &0x1::string::String {
        &arg0.name
    }

    public fun project_url(arg0: &NftToken) : &0x2::url::Url {
        &arg0.project_url
    }

    public fun remove_admin(arg0: &mut AdminConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_root_admin(arg0, v0);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v1) == arg1) {
                0x1::vector::remove<address>(&mut arg0.admins, v1);
                let v2 = AdminRemoved{
                    admin      : arg1,
                    removed_by : v0,
                };
                0x2::event::emit<AdminRemoved>(v2);
                return
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    public fun root_admin(arg0: &AdminConfig) : address {
        arg0.root_admin
    }

    public fun set_frozen(arg0: &mut AdminConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_admin(arg0, v0);
        arg0.frozen = arg1;
        let v1 = FreezeChanged{
            frozen : arg1,
            admin  : v0,
        };
        0x2::event::emit<FreezeChanged>(v1);
    }

    public fun set_mint_paused(arg0: &mut AdminConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg1) {
            assert_admin_or_root(arg0, v0);
        } else {
            assert_root_admin(arg0, v0);
        };
        arg0.mint_paused = arg1;
        let v1 = MintPauseChanged{
            paused : arg1,
            admin  : v0,
        };
        0x2::event::emit<MintPauseChanged>(v1);
    }

    public fun transfer_nft(arg0: NftToken, arg1: address, arg2: &AdminConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.frozen, 6);
        assert_not_zero(arg1);
        0x2::transfer::transfer<NftToken>(arg0, arg1);
    }

    public fun transfer_root_admin(arg0: &mut AdminConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_root_admin(arg0, v0);
        assert_not_zero(arg1);
        arg0.root_admin = arg1;
        let v1 = RootAdminTransferred{
            old_root_admin : v0,
            new_root_admin : arg1,
        };
        0x2::event::emit<RootAdminTransferred>(v1);
    }

    public fun update_animation_url(arg0: &mut NftToken, arg1: &AdminConfig, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert_bytes_len(&arg2, 2048);
        arg0.animation_url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v1 = NFTFieldUpdated{
            object_id : 0x2::object::id<NftToken>(arg0),
            admin     : v0,
            field     : 0x1::string::utf8(b"animation_url"),
        };
        0x2::event::emit<NFTFieldUpdated>(v1);
    }

    public fun update_description(arg0: &mut NftToken, arg1: &AdminConfig, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert_bytes_len(&arg2, 1024);
        arg0.description = 0x1::string::utf8(arg2);
        let v1 = NFTFieldUpdated{
            object_id : 0x2::object::id<NftToken>(arg0),
            admin     : v0,
            field     : 0x1::string::utf8(b"description"),
        };
        0x2::event::emit<NFTFieldUpdated>(v1);
    }

    public fun update_image_url(arg0: &mut NftToken, arg1: &AdminConfig, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert_bytes_len(&arg2, 2048);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v1 = NFTFieldUpdated{
            object_id : 0x2::object::id<NftToken>(arg0),
            admin     : v0,
            field     : 0x1::string::utf8(b"image_url"),
        };
        0x2::event::emit<NFTFieldUpdated>(v1);
    }

    public fun update_metadata_url(arg0: &mut NftToken, arg1: &AdminConfig, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert_bytes_len(&arg2, 2048);
        arg0.metadata_url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v1 = NFTFieldUpdated{
            object_id : 0x2::object::id<NftToken>(arg0),
            admin     : v0,
            field     : 0x1::string::utf8(b"metadata_url"),
        };
        0x2::event::emit<NFTFieldUpdated>(v1);
    }

    public fun update_name(arg0: &mut NftToken, arg1: &AdminConfig, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert_bytes_len(&arg2, 128);
        arg0.name = 0x1::string::utf8(arg2);
        let v1 = NFTFieldUpdated{
            object_id : 0x2::object::id<NftToken>(arg0),
            admin     : v0,
            field     : 0x1::string::utf8(b"name"),
        };
        0x2::event::emit<NFTFieldUpdated>(v1);
    }

    public fun update_project_url(arg0: &mut NftToken, arg1: &AdminConfig, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_admin(arg1, v0);
        assert_bytes_len(&arg2, 2048);
        arg0.project_url = 0x2::url::new_unsafe_from_bytes(arg2);
        let v1 = NFTFieldUpdated{
            object_id : 0x2::object::id<NftToken>(arg0),
            admin     : v0,
            field     : 0x1::string::utf8(b"project_url"),
        };
        0x2::event::emit<NFTFieldUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}


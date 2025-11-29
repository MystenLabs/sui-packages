module 0x42c2cca562748d88490acb58109d4f8621ac3e170346aa60c6e52f7c50366546::xociety_frontier {
    struct XOCIETY_FRONTIER has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        is_paused: bool,
        minted_token_ids: 0x2::table::Table<u64, bool>,
        multisig_pks: vector<vector<u8>>,
        multisig_weights: vector<u8>,
        multisig_threshold: u16,
        multisig_configured: bool,
        pending_admin: 0x1::option::Option<address>,
        pending_admin_accepted: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Minted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        minter: address,
    }

    struct CapEvent has copy, drop {
        cap_type: 0x1::string::String,
        action: 0x1::string::String,
        cap_id: 0x2::object::ID,
        actor: address,
        recipient: 0x1::option::Option<address>,
    }

    struct MultisigConfigChanged has copy, drop {
        num_signers: u64,
        threshold: u16,
        actor: address,
    }

    struct NftUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        updater: address,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        old_description: 0x1::string::String,
        new_description: 0x1::string::String,
        old_image_url: 0x1::string::String,
        new_image_url: 0x1::string::String,
    }

    struct PauseStateChanged has copy, drop {
        is_paused: bool,
        actor: address,
    }

    struct XocietyFrontier has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTMetadata has copy, drop {
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun accept_admin_cap(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 7);
        assert!(*0x1::option::borrow<address>(&arg0.pending_admin) == 0x2::tx_context::sender(arg1), 6);
        arg0.pending_admin_accepted = true;
        let v0 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_accepted"),
            cap_id    : 0x2::object::id_from_address(@0x0),
            actor     : 0x2::tx_context::sender(arg1),
            recipient : 0x1::option::some<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::event::emit<CapEvent>(v0);
    }

    public fun accept_admin_cap_execute(arg0: &mut Config, arg1: AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 7);
        assert!(arg0.pending_admin_accepted == true, 9);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        arg0.pending_admin = 0x1::option::none<address>();
        arg0.pending_admin_accepted = false;
        let v1 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_completed"),
            cap_id    : 0x2::object::id<AdminCap>(&arg1),
            actor     : 0x2::tx_context::sender(arg2),
            recipient : 0x1::option::some<address>(v0),
        };
        0x2::event::emit<CapEvent>(v1);
        0x2::transfer::transfer<AdminCap>(arg1, v0);
    }

    public fun get_metadata(arg0: &XocietyFrontier) : NFTMetadata {
        NFTMetadata{
            token_id    : arg0.token_id,
            name        : arg0.name,
            description : arg0.description,
            image_url   : arg0.image_url,
            attributes  : arg0.attributes,
        }
    }

    public fun get_multisig_address(arg0: &Config) : address {
        assert!(arg0.multisig_configured, 5);
        0x42c2cca562748d88490acb58109d4f8621ac3e170346aa60c6e52f7c50366546::multisig::derive_multisig_address_quiet(arg0.multisig_pks, arg0.multisig_weights, arg0.multisig_threshold)
    }

    public fun get_token_id(arg0: &XocietyFrontier) : u64 {
        arg0.token_id
    }

    fun init(arg0: XOCIETY_FRONTIER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<XOCIETY_FRONTIER>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"created"),
            cap_id    : 0x2::object::id<AdminCap>(&v1),
            actor     : 0x2::tx_context::sender(arg1),
            recipient : 0x1::option::some<address>(0x2::tx_context::sender(arg1)),
        };
        0x2::event::emit<CapEvent>(v2);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v3 = Config{
            id                     : 0x2::object::new(arg1),
            is_paused              : false,
            minted_token_ids       : 0x2::table::new<u64, bool>(arg1),
            multisig_pks           : 0x1::vector::empty<vector<u8>>(),
            multisig_weights       : 0x1::vector::empty<u8>(),
            multisig_threshold     : 0,
            multisig_configured    : false,
            pending_admin          : 0x1::option::none<address>(),
            pending_admin_accepted : false,
        };
        0x2::transfer::share_object<Config>(v3);
        let v4 = 0x2::display::new<XocietyFrontier>(&v0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"attributes"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{attributes}"));
        0x2::display::add_multiple<XocietyFrontier>(&mut v4, v5, v7);
        0x2::display::update_version<XocietyFrontier>(&mut v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<XocietyFrontier>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg9);
        assert!(!arg0.is_paused, 2);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 1);
        assert!(!0x2::table::contains<u64, bool>(&arg0.minted_token_ids, arg2), 3);
        0x2::table::add<u64, bool>(&mut arg0.minted_token_ids, arg2, true);
        let v0 = XocietyFrontier{
            id          : 0x2::object::new(arg9),
            token_id    : arg2,
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg6, arg7),
        };
        let v1 = Minted{
            nft_id    : 0x2::object::id<XocietyFrontier>(&v0),
            recipient : arg8,
            minter    : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::public_transfer<XocietyFrontier>(v0, arg8);
    }

    public fun pause(arg0: &mut Config, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg2);
        arg0.is_paused = true;
        let v0 = PauseStateChanged{
            is_paused : true,
            actor     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PauseStateChanged>(v0);
    }

    public fun renounce_admin_cap_transfer(arg0: &mut Config, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 7);
        arg0.pending_admin = 0x1::option::none<address>();
        arg0.pending_admin_accepted = false;
        let v0 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_renounced"),
            cap_id    : 0x2::object::id<AdminCap>(arg1),
            actor     : 0x2::tx_context::sender(arg2),
            recipient : 0x1::option::some<address>(*0x1::option::borrow<address>(&arg0.pending_admin)),
        };
        0x2::event::emit<CapEvent>(v0);
    }

    public fun set_multisig_config(arg0: &mut Config, arg1: &AdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &0x2::tx_context::TxContext) {
        if (arg0.multisig_configured) {
            verify_multisig_sender(arg0, arg5);
        };
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 > 0, 10);
        assert!(v1 > 0, 10);
        assert!(v0 <= 10, 13);
        assert!(v0 == v1, 11);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg2, v2));
            let v4 = if (v3 == 32) {
                true
            } else if (v3 == 33) {
                true
            } else {
                v3 == 33
            };
            assert!(v4, 14);
            v2 = v2 + 1;
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            v5 = v5 + (*0x1::vector::borrow<u8>(&arg3, v6) as u16);
            v6 = v6 + 1;
        };
        assert!(arg4 > 0, 12);
        assert!(arg4 <= v5, 12);
        arg0.multisig_pks = arg2;
        arg0.multisig_weights = arg3;
        arg0.multisig_threshold = arg4;
        arg0.multisig_configured = true;
        let v7 = MultisigConfigChanged{
            num_signers : v0,
            threshold   : arg4,
            actor       : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MultisigConfigChanged>(v7);
    }

    public fun transfer_admin_cap_begin(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 8);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 8);
        arg0.pending_admin = 0x1::option::some<address>(arg2);
        arg0.pending_admin_accepted = false;
        let v0 = CapEvent{
            cap_type  : 0x1::string::utf8(b"AdminCap"),
            action    : 0x1::string::utf8(b"transfer_initiated"),
            cap_id    : 0x2::object::id<AdminCap>(arg1),
            actor     : 0x2::tx_context::sender(arg3),
            recipient : 0x1::option::some<address>(arg2),
        };
        0x2::event::emit<CapEvent>(v0);
    }

    public fun unpause(arg0: &mut Config, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg2);
        arg0.is_paused = false;
        let v0 = PauseStateChanged{
            is_paused : false,
            actor     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PauseStateChanged>(v0);
    }

    public fun update_nft(arg0: &Config, arg1: &AdminCap, arg2: &mut XocietyFrontier, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &0x2::tx_context::TxContext) {
        verify_multisig_sender(arg0, arg8);
        assert!(!arg0.is_paused, 2);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 1);
        arg2.name = arg3;
        arg2.description = arg4;
        arg2.image_url = arg5;
        arg2.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg6, arg7);
        let v0 = NftUpdated{
            nft_id          : 0x2::object::id<XocietyFrontier>(arg2),
            token_id        : arg2.token_id,
            updater         : 0x2::tx_context::sender(arg8),
            old_name        : arg2.name,
            new_name        : arg3,
            old_description : arg2.description,
            new_description : arg4,
            old_image_url   : arg2.image_url,
            new_image_url   : arg5,
        };
        0x2::event::emit<NftUpdated>(v0);
    }

    fun verify_multisig_sender(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.multisig_configured, 5);
        assert!(0x2::tx_context::sender(arg1) == 0x42c2cca562748d88490acb58109d4f8621ac3e170346aa60c6e52f7c50366546::multisig::derive_multisig_address_quiet(arg0.multisig_pks, arg0.multisig_weights, arg0.multisig_threshold), 4);
    }

    // decompiled from Move bytecode v6
}


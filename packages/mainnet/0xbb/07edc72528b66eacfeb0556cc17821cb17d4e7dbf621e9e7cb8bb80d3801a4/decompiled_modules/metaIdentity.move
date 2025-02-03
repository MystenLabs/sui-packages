module 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity {
    struct MetaIdentity has key {
        id: 0x2::object::UID,
        metaId: u64,
        name: 0x1::string::String,
        phone: 0x1::string::String,
        email: 0x1::string::String,
        bind_status: bool,
        items: 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::Items,
        wallet: address,
    }

    struct RegisterEvent has copy, drop {
        name: 0x1::string::String,
        email: 0x1::string::String,
    }

    struct MetaInfoGlobal has key {
        id: 0x2::object::UID,
        creator: address,
        total_players: u64,
        meta_alpha_count: u64,
        meta_common_user_count: u64,
        alpha_whitelist: 0x2::table::Table<address, u64>,
        wallet_meta_map: 0x2::table::Table<address, address>,
        phone_meta_map: 0x2::table::Table<0x1::string::String, address>,
        wallet_phone_map: 0x2::table::Table<address, 0x1::string::String>,
        register_owner: address,
        inviteMap: 0x2::linked_table::LinkedTable<u64, vector<address>>,
        invitedMap: 0x2::linked_table::LinkedTable<u64, vector<address>>,
        version: u64,
    }

    public fun get_items_info(arg0: &MetaIdentity, arg1: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::ItemGlobal) : 0x1::string::String {
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::get_items_info(arg1, &arg0.items)
    }

    public fun add_whitelist_by_type(arg0: &mut MetaInfoGlobal, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010 == 0x2::tx_context::sender(arg3), 4);
        assert!(arg2 == 0, 17);
        let v0 = &mut arg0.alpha_whitelist;
        assert!(0x2::table::length<address, u64>(v0) == 0, 1);
        0x2::table::add<address, u64>(v0, arg1, 0);
    }

    public fun add_whitelists_by_type(arg0: &mut MetaInfoGlobal, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010 == 0x2::tx_context::sender(arg3), 4);
        assert!(arg2 == 0, 17);
        let v0 = &mut arg0.alpha_whitelist;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x2::table::add<address, u64>(v0, 0x1::vector::pop_back<address>(&mut arg1), 0);
            v1 = v1 + 1;
        };
    }

    public entry fun bindMeta(arg0: &mut MetaInfoGlobal, arg1: &mut MetaIdentity, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bind_status == false, 8);
        arg1.phone = arg2;
        arg1.email = arg3;
        arg1.bind_status = true;
        0x2::table::add<0x1::string::String, address>(&mut arg0.phone_meta_map, arg1.phone, 0x2::object::uid_to_address(&arg1.id));
        0x2::table::add<address, 0x1::string::String>(&mut arg0.wallet_phone_map, 0x2::tx_context::sender(arg4), arg2);
    }

    public fun change_owner(arg0: &mut MetaInfoGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 4);
        arg0.creator = arg1;
    }

    public fun change_register_owner(arg0: &mut MetaInfoGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4);
        arg0.register_owner = arg1;
    }

    public fun check_bind_relationship(arg0: &MetaInfoGlobal, arg1: 0x1::string::String, arg2: address) : bool {
        *0x2::table::borrow<address, 0x1::string::String>(&arg0.wallet_phone_map, arg2) == arg1
    }

    public entry fun deleteMeta(arg0: MetaIdentity) {
        let MetaIdentity {
            id          : v0,
            metaId      : _,
            name        : _,
            phone       : _,
            email       : _,
            bind_status : _,
            items       : v6,
            wallet      : _,
        } = arg0;
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::destroy_empty(v6);
        0x2::object::delete(v0);
    }

    fun generateUid(arg0: &mut MetaInfoGlobal, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.alpha_whitelist, arg1)) {
            let v1 = arg0.meta_alpha_count;
            let v0 = v1;
            if (v1 >= 10000) {
                v0 = get_common_metaid(arg0);
            } else {
                arg0.meta_alpha_count = arg0.meta_alpha_count + 1;
            };
            v0
        } else {
            get_common_metaid(arg0)
        }
    }

    public fun getAddr(arg0: &MetaIdentity) : address {
        arg0.wallet
    }

    public fun getMetaId(arg0: &MetaIdentity) : u64 {
        arg0.metaId
    }

    fun get_common_metaid(arg0: &mut MetaInfoGlobal) : u64 {
        arg0.meta_common_user_count = arg0.meta_common_user_count + 1;
        10000 + arg0.meta_common_user_count
    }

    public fun get_items(arg0: &mut MetaIdentity) : &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::Items {
        &mut arg0.items
    }

    public fun get_meta_id(arg0: &MetaIdentity) : u64 {
        arg0.metaId
    }

    public fun get_meta_name(arg0: &MetaIdentity) : 0x1::string::String {
        arg0.name
    }

    public fun get_total_players(arg0: &MetaInfoGlobal) : u64 {
        arg0.total_players
    }

    public fun increment(arg0: &mut MetaInfoGlobal, arg1: u64) {
        assert!(arg0.version == 0, 32);
        arg0.version = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetaInfoGlobal{
            id                     : 0x2::object::new(arg0),
            creator                : @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010,
            total_players          : 0,
            meta_alpha_count       : 0,
            meta_common_user_count : 0,
            alpha_whitelist        : 0x2::table::new<address, u64>(arg0),
            wallet_meta_map        : 0x2::table::new<address, address>(arg0),
            phone_meta_map         : 0x2::table::new<0x1::string::String, address>(arg0),
            wallet_phone_map       : 0x2::table::new<address, 0x1::string::String>(arg0),
            register_owner         : @0x18889a72b0cd8072196ee4cf269a16d8e559c69088f7488ecb76de002f088010,
            inviteMap              : 0x2::linked_table::new<u64, vector<address>>(arg0),
            invitedMap             : 0x2::linked_table::new<u64, vector<address>>(arg0),
            version                : 0,
        };
        0x2::transfer::share_object<MetaInfoGlobal>(v0);
    }

    public entry fun inviteSendSui(arg0: &mut MetaInfoGlobal, arg1: u64, arg2: address, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 32);
        let v0 = 1000000000 / 10;
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg3);
        assert!(!is_registered(arg0, arg2), 22);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) >= v0, 20);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v0, arg4), arg2);
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        if (0x2::linked_table::contains<u64, vector<address>>(&arg0.inviteMap, arg1)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, vector<address>>(&mut arg0.inviteMap, arg1);
            assert!(!0x1::vector::contains<address>(v2, &arg2), 21);
            0x1::vector::push_back<address>(v2, arg2);
        } else {
            let v3 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v3, arg2);
            0x2::linked_table::push_back<u64, vector<address>>(&mut arg0.inviteMap, arg1, v3);
        };
    }

    public fun is_active(arg0: &MetaIdentity) : bool {
        arg0.bind_status
    }

    public fun is_registered(arg0: &MetaInfoGlobal, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg1)
    }

    public entry fun mintInviteMeta(arg0: &mut MetaInfoGlobal, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 32);
        assert!(!0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg5), 8);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = generateUid(arg0, arg5);
        let v3 = MetaIdentity{
            id          : v0,
            metaId      : v2,
            name        : arg2,
            phone       : arg3,
            email       : arg4,
            bind_status : true,
            items       : 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::new(arg6),
            wallet      : arg5,
        };
        assert!(0x2::linked_table::contains<u64, vector<address>>(&arg0.inviteMap, arg1), 25);
        assert!(0x1::vector::contains<address>(0x2::linked_table::borrow<u64, vector<address>>(&arg0.inviteMap, arg1), &arg5), 24);
        if (!0x2::linked_table::contains<u64, vector<address>>(&arg0.invitedMap, arg1)) {
            let v4 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v4, arg5);
            0x2::linked_table::push_back<u64, vector<address>>(&mut arg0.invitedMap, arg1, v4);
        } else {
            let v5 = 0x2::linked_table::borrow_mut<u64, vector<address>>(&mut arg0.invitedMap, arg1);
            assert!(!0x1::vector::contains<address>(v5, &arg5), 23);
            0x1::vector::push_back<address>(v5, arg5);
        };
        assert!(!0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg5), 19);
        0x2::table::add<address, address>(&mut arg0.wallet_meta_map, arg5, v1);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.phone_meta_map, arg3), 18);
        0x2::table::add<0x1::string::String, address>(&mut arg0.phone_meta_map, arg3, v1);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.wallet_phone_map, arg5), 19);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.wallet_phone_map, arg5, arg3);
        0x2::transfer::transfer<MetaIdentity>(v3, arg5);
        let v6 = RegisterEvent{
            name  : arg2,
            email : arg4,
        };
        0x2::event::emit<RegisterEvent>(v6);
        arg0.total_players = arg0.total_players + 1;
    }

    public entry fun mintMeta(arg0: &mut MetaInfoGlobal, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 32);
        assert!(!0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg4), 8);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = generateUid(arg0, arg4);
        let v3 = MetaIdentity{
            id          : v0,
            metaId      : v2,
            name        : arg1,
            phone       : arg2,
            email       : arg3,
            bind_status : true,
            items       : 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::items::new(arg5),
            wallet      : 0x2::tx_context::sender(arg5),
        };
        assert!(!0x2::table::contains<address, address>(&arg0.wallet_meta_map, arg4), 19);
        0x2::table::add<address, address>(&mut arg0.wallet_meta_map, arg4, v1);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.phone_meta_map, arg2), 18);
        0x2::table::add<0x1::string::String, address>(&mut arg0.phone_meta_map, arg2, v1);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.wallet_phone_map, arg4), 19);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.wallet_phone_map, arg4, arg2);
        0x2::transfer::transfer<MetaIdentity>(v3, arg4);
        let v4 = RegisterEvent{
            name  : arg1,
            email : arg3,
        };
        0x2::event::emit<RegisterEvent>(v4);
        arg0.total_players = arg0.total_players + 1;
    }

    public entry fun query_invited_num(arg0: &MetaInfoGlobal, arg1: u64) : u64 {
        if (0x2::linked_table::contains<u64, vector<address>>(&arg0.invitedMap, arg1)) {
            0x1::vector::length<address>(0x2::linked_table::borrow<u64, vector<address>>(&arg0.invitedMap, arg1))
        } else {
            0
        }
    }

    public fun query_meta_by_address(arg0: &MetaInfoGlobal, arg1: address) : &address {
        0x2::table::borrow<address, address>(&arg0.wallet_meta_map, arg1)
    }

    public fun query_meta_by_phone(arg0: &MetaInfoGlobal, arg1: 0x1::string::String) : &address {
        0x2::table::borrow<0x1::string::String, address>(&arg0.phone_meta_map, arg1)
    }

    public fun transferMeta(arg0: &mut MetaInfoGlobal, arg1: MetaIdentity, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<address, address>(&mut arg0.wallet_meta_map, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg1;
        unbindMeta(arg0, v0, arg3);
        0x2::transfer::transfer<MetaIdentity>(arg1, arg2);
    }

    public entry fun unbindMeta(arg0: &mut MetaInfoGlobal, arg1: &mut MetaIdentity, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.bind_status == true, 3);
        arg1.phone = 0x1::string::utf8(b"");
        arg1.email = 0x1::string::utf8(b"");
        arg1.bind_status = false;
        0x2::table::remove<0x1::string::String, address>(&mut arg0.phone_meta_map, arg1.phone);
        0x2::table::remove<address, 0x1::string::String>(&mut arg0.wallet_phone_map, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


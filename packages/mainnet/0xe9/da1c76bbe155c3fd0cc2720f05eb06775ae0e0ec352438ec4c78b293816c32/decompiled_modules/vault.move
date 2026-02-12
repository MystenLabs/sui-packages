module 0xe9da1c76bbe155c3fd0cc2720f05eb06775ae0e0ec352438ec4c78b293816c32::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Package has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        vaults: u64,
        free_invites_per_vault: u64,
    }

    struct Tier has copy, drop, store {
        min_vaults: u64,
        price: u64,
    }

    struct UserInfo has store {
        vaults_created: u64,
        credits: 0x2::table::Table<u64, u64>,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        treasury_address: address,
        invite_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        packages: vector<Package>,
        tiers: vector<Tier>,
        user_infos: 0x2::table::Table<address, UserInfo>,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        members: vector<address>,
        member_roles: 0x2::table::Table<address, u8>,
        free_invites_remaining: u64,
        secrets: 0x2::table::Table<0x2::object::ID, bool>,
        creation_epoch: u64,
    }

    struct EncryptedData has copy, drop, store {
        data: vector<u8>,
        ephemeral_public_key: vector<u8>,
    }

    struct Secret has store {
        id: 0x2::object::ID,
        title: vector<u8>,
        encrypted_versions: 0x2::table::Table<address, EncryptedData>,
        created_by: address,
        timestamp: u64,
    }

    struct VaultCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
        creation_epoch: u64,
    }

    struct SecretAdded has copy, drop {
        vault_id: 0x2::object::ID,
        secret_id: 0x2::object::ID,
    }

    struct SecretUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        secret_id: 0x2::object::ID,
    }

    struct MemberAdded has copy, drop {
        vault_id: 0x2::object::ID,
        member: address,
        role: u8,
    }

    struct MemberRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        member: address,
    }

    public fun add_encrypted_version_to_secret(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        check_vault_validity(arg0, arg5);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg5)), 0);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        assert_is_vault_member(arg0, arg2);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Secret>(&mut arg0.id, arg1);
        let v1 = EncryptedData{
            data                 : arg3,
            ephemeral_public_key : arg4,
        };
        if (0x2::table::contains<address, EncryptedData>(&v0.encrypted_versions, arg2)) {
            0x2::table::remove<address, EncryptedData>(&mut v0.encrypted_versions, arg2);
        };
        0x2::table::add<address, EncryptedData>(&mut v0.encrypted_versions, arg2, v1);
    }

    public fun add_member(arg0: &mut GlobalConfig, arg1: &mut Vault, arg2: address, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        check_vault_validity(arg1, arg5);
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg5)), 0);
        assert!(!0x1::vector::contains<address>(&arg1.members, &arg2), 0);
        let v0 = arg0.invite_fee;
        if (arg1.free_invites_remaining > 0) {
            v0 = 0;
            arg1.free_invites_remaining = arg1.free_invites_remaining - 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 4);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0));
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        };
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_infos, arg2)) {
            let v2 = UserInfo{
                vaults_created : 0,
                credits        : 0x2::table::new<u64, u64>(arg5),
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_infos, arg2, v2);
        };
        0x1::vector::push_back<address>(&mut arg1.members, arg2);
        0x2::table::add<address, u8>(&mut arg1.member_roles, arg2, arg3);
        let v3 = MemberAdded{
            vault_id : 0x2::object::id<Vault>(arg1),
            member   : arg2,
            role     : arg3,
        };
        0x2::event::emit<MemberAdded>(v3);
    }

    public fun add_package(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Package{
            name                   : arg2,
            price                  : arg3,
            vaults                 : arg4,
            free_invites_per_vault : arg5,
        };
        0x1::vector::push_back<Package>(&mut arg1.packages, v0);
    }

    public fun add_secret(arg0: &mut Vault, arg1: vector<u8>, arg2: vector<address>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_vault_validity(arg0, arg6);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg6)), 2);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<address>(&arg2), 6);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<address>(&arg2), 6);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x2::object::delete(v0);
        let v2 = Secret{
            id                 : v1,
            title              : arg1,
            encrypted_versions : 0x2::table::new<address, EncryptedData>(arg6),
            created_by         : 0x2::tx_context::sender(arg6),
            timestamp          : 0x2::clock::timestamp_ms(arg5),
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg2)) {
            let v4 = *0x1::vector::borrow<address>(&arg2, v3);
            assert_is_vault_member(arg0, v4);
            let v5 = EncryptedData{
                data                 : *0x1::vector::borrow<vector<u8>>(&arg3, v3),
                ephemeral_public_key : *0x1::vector::borrow<vector<u8>>(&arg4, v3),
            };
            0x2::table::add<address, EncryptedData>(&mut v2.encrypted_versions, v4, v5);
            v3 = v3 + 1;
        };
        0x2::dynamic_field::add<0x2::object::ID, Secret>(&mut arg0.id, v1, v2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.secrets, v1, true);
        let v6 = SecretAdded{
            vault_id  : 0x2::object::id<Vault>(arg0),
            secret_id : v1,
        };
        0x2::event::emit<SecretAdded>(v6);
        v1
    }

    public fun add_tier(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64) {
        let v0 = Tier{
            min_vaults : arg2,
            price      : arg3,
        };
        0x1::vector::push_back<Tier>(&mut arg1.tiers, v0);
    }

    fun assert_is_vault_member(arg0: &Vault, arg1: address) {
        assert!(is_authorized(arg0, arg1), 3);
    }

    public fun buy_package(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v0 < 0x1::vector::length<Package>(&arg0.packages)) {
            let v5 = 0x1::vector::borrow<Package>(&arg0.packages, v0);
            if (v5.name == arg1) {
                v2 = v5.price;
                v3 = v5.vaults;
                v4 = v5.free_invites_per_vault;
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 4);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v2));
        if (0x2::balance::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v7 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_infos, v7)) {
            let v8 = UserInfo{
                vaults_created : 0,
                credits        : 0x2::table::new<u64, u64>(arg3),
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_infos, v7, v8);
        };
        let v9 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, v7);
        if (0x2::table::contains<u64, u64>(&v9.credits, v4)) {
            0x2::table::remove<u64, u64>(&mut v9.credits, v4);
            0x2::table::add<u64, u64>(&mut v9.credits, v4, *0x2::table::borrow<u64, u64>(&v9.credits, v4) + v3);
        } else {
            0x2::table::add<u64, u64>(&mut v9.credits, v4, v3);
        };
    }

    public fun check_vault_validity(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        if (2 > 18446744073709551615 - arg0.creation_epoch) {
            return
        };
        if (0x2::tx_context::epoch(arg1) > arg0.creation_epoch + 2) {
            abort 7
        };
    }

    public fun create_vault(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_infos, v0)) {
            let v1 = UserInfo{
                vaults_created : 0,
                credits        : 0x2::table::new<u64, u64>(arg4),
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_infos, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_infos, v0);
        let v3 = 0;
        let v4 = 0;
        let v5 = v2.vaults_created;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = false;
        while (v7 < 0x1::vector::length<Tier>(&arg0.tiers)) {
            let v10 = 0x1::vector::borrow<Tier>(&arg0.tiers, v7);
            if (v5 >= v10.min_vaults) {
                if (!v9 || v10.min_vaults > v8) {
                    v6 = v10.price;
                    v8 = v10.min_vaults;
                    v9 = true;
                };
            };
            v7 = v7 + 1;
        };
        if (v6 == 0) {
        } else {
            let v11 = false;
            if (0x1::option::is_some<u64>(&arg2)) {
                let v12 = *0x1::option::borrow<u64>(&arg2);
                if (0x2::table::contains<u64, u64>(&v2.credits, v12)) {
                    let v13 = *0x2::table::borrow<u64, u64>(&v2.credits, v12);
                    if (v13 > 0) {
                        v4 = v12;
                        0x2::table::remove<u64, u64>(&mut v2.credits, v12);
                        if (v13 > 1) {
                            0x2::table::add<u64, u64>(&mut v2.credits, v12, v13 - 1);
                        };
                        v11 = true;
                    };
                };
            };
            if (!v11) {
                let v14 = 0;
                let v15 = v14;
                let v16 = false;
                let v17 = 0;
                while (v17 < 0x1::vector::length<Package>(&arg0.packages)) {
                    let v18 = 0x1::vector::borrow<Package>(&arg0.packages, v17).free_invites_per_vault;
                    if (0x2::table::contains<u64, u64>(&v2.credits, v18)) {
                        if (*0x2::table::borrow<u64, u64>(&v2.credits, v18) > 0) {
                            if (!v16 || v18 > v14) {
                                v15 = v18;
                                v16 = true;
                            };
                        };
                    };
                    v17 = v17 + 1;
                };
                if (v16) {
                    v4 = v15;
                    let v19 = *0x2::table::borrow<u64, u64>(&v2.credits, v15);
                    0x2::table::remove<u64, u64>(&mut v2.credits, v15);
                    if (v19 > 1) {
                        0x2::table::add<u64, u64>(&mut v2.credits, v15, v19 - 1);
                    };
                    v11 = true;
                };
            };
            if (!v11) {
                v3 = v6;
            };
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v3, 4);
        let v20 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v20, v3));
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v20, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v20);
        };
        v2.vaults_created = v2.vaults_created + 1;
        let v21 = Vault{
            id                     : 0x2::object::new(arg4),
            name                   : arg1,
            owner                  : v0,
            members                : 0x1::vector::empty<address>(),
            member_roles           : 0x2::table::new<address, u8>(arg4),
            free_invites_remaining : v4,
            secrets                : 0x2::table::new<0x2::object::ID, bool>(arg4),
            creation_epoch         : 0x2::tx_context::epoch(arg4),
        };
        let v22 = VaultCreated{
            id             : 0x2::object::id<Vault>(&v21),
            name           : arg1,
            owner          : v0,
            creation_epoch : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<VaultCreated>(v22);
        0x2::transfer::share_object<Vault>(v21);
    }

    public fun get_secret_for_member(arg0: &Vault, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (vector<u8>, vector<u8>) {
        assert!(is_authorized(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x2::tx_context::sender(arg3) == arg2, 0);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, Secret>(&arg0.id, arg1);
        assert!(0x2::table::contains<address, EncryptedData>(&v0.encrypted_versions, arg2), 3);
        let v1 = 0x2::table::borrow<address, EncryptedData>(&v0.encrypted_versions, arg2);
        (v1.data, v1.ephemeral_public_key)
    }

    public fun grant_credits(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserInfo>(&arg1.user_infos, arg2)) {
            let v0 = UserInfo{
                vaults_created : 0,
                credits        : 0x2::table::new<u64, u64>(arg5),
            };
            0x2::table::add<address, UserInfo>(&mut arg1.user_infos, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg1.user_infos, arg2);
        if (0x2::table::contains<u64, u64>(&v1.credits, arg3)) {
            0x2::table::remove<u64, u64>(&mut v1.credits, arg3);
            0x2::table::add<u64, u64>(&mut v1.credits, arg3, *0x2::table::borrow<u64, u64>(&v1.credits, arg3) + arg4);
        } else {
            0x2::table::add<u64, u64>(&mut v1.credits, arg3, arg4);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<Package>();
        let v2 = Package{
            name                   : 0x1::string::utf8(b"100-Vault Pack"),
            price                  : 49000000000,
            vaults                 : 100,
            free_invites_per_vault : 3,
        };
        0x1::vector::push_back<Package>(&mut v1, v2);
        let v3 = Package{
            name                   : 0x1::string::utf8(b"500-Vault Pack"),
            price                  : 199000000000,
            vaults                 : 500,
            free_invites_per_vault : 5,
        };
        0x1::vector::push_back<Package>(&mut v1, v3);
        let v4 = Package{
            name                   : 0x1::string::utf8(b"1,000-Vault Pack"),
            price                  : 349000000000,
            vaults                 : 1000,
            free_invites_per_vault : 20,
        };
        0x1::vector::push_back<Package>(&mut v1, v4);
        let v5 = Package{
            name                   : 0x1::string::utf8(b"10,000+ Vault Pack"),
            price                  : 2499000000000,
            vaults                 : 10000,
            free_invites_per_vault : 100,
        };
        0x1::vector::push_back<Package>(&mut v1, v5);
        let v6 = 0x1::vector::empty<Tier>();
        let v7 = Tier{
            min_vaults : 0,
            price      : 0,
        };
        0x1::vector::push_back<Tier>(&mut v6, v7);
        let v8 = Tier{
            min_vaults : 1,
            price      : 990000000,
        };
        0x1::vector::push_back<Tier>(&mut v6, v8);
        let v9 = Tier{
            min_vaults : 10,
            price      : 870000000,
        };
        0x1::vector::push_back<Tier>(&mut v6, v9);
        let v10 = GlobalConfig{
            id               : 0x2::object::new(arg0),
            treasury_address : 0x2::tx_context::sender(arg0),
            invite_fee       : 500000000,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            packages         : v1,
            tiers            : v6,
            user_infos       : 0x2::table::new<address, UserInfo>(arg0),
        };
        0x2::transfer::share_object<GlobalConfig>(v10);
    }

    public fun is_admin(arg0: &Vault, arg1: address) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        if (0x2::table::contains<address, u8>(&arg0.member_roles, arg1)) {
            return *0x2::table::borrow<address, u8>(&arg0.member_roles, arg1) == 1
        };
        false
    }

    public fun is_authorized(arg0: &Vault, arg1: address) : bool {
        if (arg0.owner == arg1) {
            return true
        };
        0x1::vector::contains<address>(&arg0.members, &arg1)
    }

    public fun remove_member(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_vault_validity(arg0, arg2);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(arg1 != arg0.owner, 0);
        assert!(0x1::vector::contains<address>(&arg0.members, &arg1), 3);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.members, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.members, v1);
        };
        if (0x2::table::contains<address, u8>(&arg0.member_roles, arg1)) {
            0x2::table::remove<address, u8>(&mut arg0.member_roles, arg1);
        };
        let v2 = MemberRemoved{
            vault_id : 0x2::object::id<Vault>(arg0),
            member   : arg1,
        };
        0x2::event::emit<MemberRemoved>(v2);
    }

    public fun remove_package(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        if (arg2 < 0x1::vector::length<Package>(&arg1.packages)) {
            0x1::vector::remove<Package>(&mut arg1.packages, arg2);
        };
    }

    public fun remove_secret(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        check_vault_validity(arg0, arg2);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 2);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.secrets, arg1)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg0.secrets, arg1);
        };
        let Secret {
            id                 : _,
            title              : _,
            encrypted_versions : v2,
            created_by         : _,
            timestamp          : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Secret>(&mut arg0.id, arg1);
        0x2::table::drop<address, EncryptedData>(v2);
    }

    public fun remove_tier(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        if (arg2 < 0x1::vector::length<Tier>(&arg1.tiers)) {
            0x1::vector::remove<Tier>(&mut arg1.tiers, arg2);
        };
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public fun set_vault_free_invites(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) {
        arg1.free_invites_remaining = arg2;
    }

    public fun update_fees(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.invite_fee = arg2;
    }

    public fun update_package(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64) {
        if (arg2 < 0x1::vector::length<Package>(&arg1.packages)) {
            let v0 = 0x1::vector::borrow_mut<Package>(&mut arg1.packages, arg2);
            v0.name = arg3;
            v0.price = arg4;
            v0.vaults = arg5;
            v0.free_invites_per_vault = arg6;
        };
    }

    public fun update_packages(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u64>(&arg3), 6);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 6);
        assert!(0x1::vector::length<u64>(&arg4) == 0x1::vector::length<u64>(&arg5), 6);
        let v0 = 0x1::vector::empty<Package>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = Package{
                name                   : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                price                  : *0x1::vector::borrow<u64>(&arg3, v1),
                vaults                 : *0x1::vector::borrow<u64>(&arg4, v1),
                free_invites_per_vault : *0x1::vector::borrow<u64>(&arg5, v1),
            };
            0x1::vector::push_back<Package>(&mut v0, v2);
            v1 = v1 + 1;
        };
        arg1.packages = v0;
    }

    public fun update_secret(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_vault_validity(arg0, arg7);
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg7)), 2);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<address>(&arg3), 6);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == 0x1::vector::length<address>(&arg3), 6);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg3);
        while (v0 < v1) {
            assert_is_vault_member(arg0, *0x1::vector::borrow<address>(&arg3, v0));
            v0 = v0 + 1;
        };
        let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Secret>(&mut arg0.id, arg1);
        v2.title = arg2;
        v0 = 0;
        while (v0 < v1) {
            let v3 = *0x1::vector::borrow<address>(&arg3, v0);
            let v4 = EncryptedData{
                data                 : *0x1::vector::borrow<vector<u8>>(&arg4, v0),
                ephemeral_public_key : *0x1::vector::borrow<vector<u8>>(&arg5, v0),
            };
            if (0x2::table::contains<address, EncryptedData>(&v2.encrypted_versions, v3)) {
                0x2::table::remove<address, EncryptedData>(&mut v2.encrypted_versions, v3);
            };
            0x2::table::add<address, EncryptedData>(&mut v2.encrypted_versions, v3, v4);
            v0 = v0 + 1;
        };
        let v5 = SecretUpdated{
            vault_id  : 0x2::object::id<Vault>(arg0),
            secret_id : arg1,
        };
        0x2::event::emit<SecretUpdated>(v5);
    }

    public fun update_tier(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64, arg4: u64) {
        if (arg2 < 0x1::vector::length<Tier>(&arg1.tiers)) {
            let v0 = 0x1::vector::borrow_mut<Tier>(&mut arg1.tiers, arg2);
            v0.min_vaults = arg3;
            v0.price = arg4;
        };
    }

    public fun update_tiers(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 6);
        let v0 = 0x1::vector::empty<Tier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = Tier{
                min_vaults : *0x1::vector::borrow<u64>(&arg2, v1),
                price      : *0x1::vector::borrow<u64>(&arg3, v1),
            };
            0x1::vector::push_back<Tier>(&mut v0, v2);
            v1 = v1 + 1;
        };
        arg1.tiers = v0;
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg2), arg1.treasury_address);
    }

    // decompiled from Move bytecode v6
}


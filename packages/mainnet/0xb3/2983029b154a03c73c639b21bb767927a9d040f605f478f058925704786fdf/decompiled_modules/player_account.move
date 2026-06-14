module 0xb32983029b154a03c73c639b21bb767927a9d040f605f478f058925704786fdf::player_account {
    struct PlayerRegistry has key {
        id: 0x2::object::UID,
        players: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct PlayerAccount has key {
        id: 0x2::object::UID,
        owner: address,
        status: u8,
        created_at: u64,
        session_nonce: u64,
        kyc_tag_hash: vector<u8>,
        vault_ids: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct PlayerAccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        created_at: u64,
    }

    struct PlayerStatusChanged has copy, drop {
        account_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        changed_at: u64,
    }

    struct PlayerKycTagUpdated has copy, drop {
        account_id: 0x2::object::ID,
        new_tag_hash: vector<u8>,
        updated_at: u64,
    }

    struct VaultRegisteredOnAccount has copy, drop {
        account_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    public fun account_id_for(arg0: &PlayerRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.players, arg1)
    }

    public(friend) fun create_account_inner(arg0: &mut PlayerRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : PlayerAccount {
        assert!(0x1::vector::length<u8>(&arg1) <= 64, 102);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.players, v0), 103);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = PlayerAccount{
            id            : 0x2::object::new(arg3),
            owner         : v0,
            status        : 1,
            created_at    : v1,
            session_nonce : 0,
            kyc_tag_hash  : arg1,
            vault_ids     : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg3),
        };
        let v3 = 0x2::object::id<PlayerAccount>(&v2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.players, v0, v3);
        let v4 = PlayerAccountCreated{
            account_id : v3,
            owner      : v0,
            created_at : v1,
        };
        0x2::event::emit<PlayerAccountCreated>(v4);
        v2
    }

    public fun create_player_account(arg0: &mut PlayerRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_account_inner(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<PlayerAccount>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun created_at(arg0: &PlayerAccount) : u64 {
        arg0.created_at
    }

    public(friend) fun give_account(arg0: PlayerAccount, arg1: address) {
        0x2::transfer::transfer<PlayerAccount>(arg0, arg1);
    }

    public fun has_vault<T0>(arg0: &PlayerAccount) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vault_ids, 0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerRegistry{
            id      : 0x2::object::new(arg0),
            players : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<PlayerRegistry>(v0);
    }

    public fun is_active(arg0: &PlayerAccount) : bool {
        arg0.status == 1
    }

    public fun is_registered(arg0: &PlayerRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.players, arg1)
    }

    public fun kyc_tag_hash(arg0: &PlayerAccount) : &vector<u8> {
        &arg0.kyc_tag_hash
    }

    public(friend) fun next_session_nonce(arg0: &mut PlayerAccount, arg1: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 100);
        assert!(arg0.status == 1, 101);
        let v0 = arg0.session_nonce;
        arg0.session_nonce = v0 + 1;
        v0
    }

    public fun owner(arg0: &PlayerAccount) : address {
        arg0.owner
    }

    public(friend) fun register_vault<T0>(arg0: &mut PlayerAccount, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vault_ids, v0), 104);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.vault_ids, v0, arg1);
        let v1 = VaultRegisteredOnAccount{
            account_id : 0x2::object::id<PlayerAccount>(arg0),
            coin_type  : v0,
            vault_id   : arg1,
        };
        0x2::event::emit<VaultRegisteredOnAccount>(v1);
    }

    public fun session_nonce(arg0: &PlayerAccount) : u64 {
        arg0.session_nonce
    }

    public(friend) fun set_status(arg0: &mut PlayerAccount, arg1: u8, arg2: &0x2::clock::Clock) {
        arg0.status = arg1;
        let v0 = PlayerStatusChanged{
            account_id : 0x2::object::id<PlayerAccount>(arg0),
            old_status : arg0.status,
            new_status : arg1,
            changed_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlayerStatusChanged>(v0);
    }

    public fun status(arg0: &PlayerAccount) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        1
    }

    public fun status_frozen() : u8 {
        2
    }

    public fun update_kyc_tag(arg0: &mut PlayerAccount, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 100);
        assert!(0x1::vector::length<u8>(&arg1) <= 64, 102);
        arg0.kyc_tag_hash = arg1;
        let v0 = PlayerKycTagUpdated{
            account_id   : 0x2::object::id<PlayerAccount>(arg0),
            new_tag_hash : arg0.kyc_tag_hash,
            updated_at   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlayerKycTagUpdated>(v0);
    }

    public fun vault_id<T0>(arg0: &PlayerAccount) : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vault_ids, v0), 105);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.vault_ids, v0)
    }

    // decompiled from Move bytecode v7
}


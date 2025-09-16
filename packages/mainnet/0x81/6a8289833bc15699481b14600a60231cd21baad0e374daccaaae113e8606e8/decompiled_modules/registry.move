module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u8,
        admin_public_key: vector<u8>,
        nonce_expiration_window: u64,
        claimed_list: 0x2::table::Table<u64, u64>,
    }

    struct WhiteListMintRegistry has key {
        id: 0x2::object::UID,
        version: u8,
        addresses: 0x2::table::Table<address, bool>,
    }

    struct PlayerRegistry has key {
        id: 0x2::object::UID,
        version: u8,
        players: 0x2::table::Table<address, bool>,
    }

    struct PoolAdminSettings has key {
        id: 0x2::object::UID,
        version: u8,
        treasury_address: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public fun add_to_player_registry(arg0: &AdminCap, arg1: &mut PlayerRegistry, arg2: address) {
        validate_player_registry_version(arg1);
        0x2::table::add<address, bool>(&mut arg1.players, arg2, true);
    }

    public fun add_to_whitelist(arg0: &AdminCap, arg1: &mut WhiteListMintRegistry, arg2: address) {
        validate_whitelist_version(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg1.addresses, arg2), 4);
        0x2::table::add<address, bool>(&mut arg1.addresses, arg2, true);
    }

    public(friend) fun admin_public_key(arg0: &Registry) : vector<u8> {
        validate_registry_version(arg0);
        arg0.admin_public_key
    }

    public fun claimed_list(arg0: &Registry) : &0x2::table::Table<u64, u64> {
        validate_registry_version(arg0);
        &arg0.claimed_list
    }

    public fun claimed_list_size(arg0: &Registry) : u64 {
        validate_registry_version(arg0);
        0x2::table::length<u64, u64>(&arg0.claimed_list)
    }

    public fun cleanup_expired_nonces(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        validate_registry_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            if (0x2::table::contains<u64, u64>(&arg1.claimed_list, v1)) {
                if (*0x2::table::borrow<u64, u64>(&arg1.claimed_list, v1) + arg1.nonce_expiration_window < 0x2::tx_context::epoch(arg3)) {
                    0x2::table::remove<u64, u64>(&mut arg1.claimed_list, v1);
                };
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REGISTRY>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Registry{
            id                      : 0x2::object::new(arg1),
            version                 : 2,
            admin_public_key        : 0x1::vector::empty<u8>(),
            nonce_expiration_window : 2,
            claimed_list            : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = WhiteListMintRegistry{
            id        : 0x2::object::new(arg1),
            version   : 2,
            addresses : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<WhiteListMintRegistry>(v1);
        let v2 = PlayerRegistry{
            id      : 0x2::object::new(arg1),
            version : 2,
            players : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<PlayerRegistry>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = PoolAdminSettings{
            id               : 0x2::object::new(arg1),
            version          : 2,
            treasury_address : @0x560862321d8508df04915d912de492d8a3cbe689a4fa76dd69d7d747ab88fb76,
        };
        0x2::transfer::share_object<PoolAdminSettings>(v4);
    }

    public fun is_player(arg0: &PlayerRegistry, arg1: address) : bool {
        validate_player_registry_version(arg0);
        0x2::table::contains<address, bool>(&arg0.players, arg1)
    }

    public(friend) fun is_whitelisted(arg0: &WhiteListMintRegistry, arg1: address) : bool {
        validate_whitelist_version(arg0);
        0x2::table::contains<address, bool>(&arg0.addresses, arg1)
    }

    public fun mint_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::package::from_package<Registry>(arg0), 13906835016156971007);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public(friend) fun new_boosterpack_claim(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        validate_registry_version(arg0);
        0x2::table::add<u64, u64>(&mut arg0.claimed_list, arg1, arg2);
    }

    public fun nonce_expiration_window(arg0: &Registry) : u64 {
        validate_registry_version(arg0);
        arg0.nonce_expiration_window
    }

    public fun pump_player_registry_version(arg0: &AdminCap, arg1: &mut PlayerRegistry) {
        arg1.version = 2;
    }

    public fun pump_pool_admin_settings_version(arg0: &AdminCap, arg1: &mut PoolAdminSettings) {
        arg1.version = 2;
    }

    public fun pump_registry_version(arg0: &AdminCap, arg1: &mut Registry) {
        arg1.version = 2;
    }

    public fun pump_whitelist_version(arg0: &AdminCap, arg1: &mut WhiteListMintRegistry) {
        arg1.version = 2;
    }

    public fun remove_from_player_registry(arg0: &AdminCap, arg1: &mut PlayerRegistry, arg2: address) {
        validate_player_registry_version(arg1);
        0x2::table::remove<address, bool>(&mut arg1.players, arg2);
    }

    public fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut WhiteListMintRegistry, arg2: address) {
        validate_whitelist_version(arg1);
        assert!(0x2::table::contains<address, bool>(&arg1.addresses, arg2), 3);
        0x2::table::remove<address, bool>(&mut arg1.addresses, arg2);
    }

    public fun treasury_address(arg0: &PoolAdminSettings) : address {
        validate_pool_admin_settings_version(arg0);
        arg0.treasury_address
    }

    public fun update_admin_public_key(arg0: &mut Registry, arg1: &AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        validate_registry_version(arg0);
        arg0.admin_public_key = arg2;
    }

    public fun update_nonce_expiration_window(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        validate_registry_version(arg1);
        arg1.nonce_expiration_window = arg2;
    }

    public fun update_treasury_address(arg0: &AdminCap, arg1: &mut PoolAdminSettings, arg2: address) {
        validate_pool_admin_settings_version(arg1);
        arg1.treasury_address = arg2;
    }

    public fun validate_player_registry_version(arg0: &PlayerRegistry) {
        assert!(arg0.version == 2, 2);
    }

    public fun validate_pool_admin_settings_version(arg0: &PoolAdminSettings) {
        assert!(arg0.version == 2, 5);
    }

    public fun validate_registry_version(arg0: &Registry) {
        assert!(arg0.version == 2, 0);
    }

    public fun validate_whitelist_version(arg0: &WhiteListMintRegistry) {
        assert!(arg0.version == 2, 1);
    }

    // decompiled from Move bytecode v6
}


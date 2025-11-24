module 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::subdomain {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintRecord has copy, drop, store {
        subdomain_name: 0x1::string::String,
        ve_sca_amount: u64,
        timestamp: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        allow_mint: bool,
        ve_sca_amount_threshold: u64,
    }

    struct DomainKiosk has key {
        id: 0x2::object::UID,
        domain: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
        mint_records: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, MintRecord>>,
        total_minted: u64,
    }

    struct SubDomainMintedEvent has copy, drop {
        parent_id: 0x2::object::ID,
        subdomain_object_id: 0x2::object::ID,
        subdomain_name: 0x1::string::String,
        timestamp: u64,
        ve_sca_key: 0x2::object::ID,
        ve_sca_amount: u64,
        user: address,
    }

    struct DomainAdded has copy, drop {
        domain: 0x2::object::ID,
        sender: address,
    }

    struct DomainTaken has copy, drop {
        domain: 0x2::object::ID,
        sender: address,
    }

    struct AmountThresholdUpdated has copy, drop {
        old_threshold: u64,
        new_threshold: u64,
        sender: address,
    }

    struct MintRecordRemoved has copy, drop {
        user: address,
        sender: address,
    }

    public fun add_batch_mint_records(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            add_to_mint_records(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public fun add_domain(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &mut 0x2::tx_context::TxContext) {
        assert_domain_not_exists(arg1);
        0x1::option::fill<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.domain, arg2);
        let v0 = DomainAdded{
            domain : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg2),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DomainAdded>(v0);
    }

    fun add_mint_record(arg0: &mut DomainKiosk, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = MintRecord{
            subdomain_name : arg3,
            ve_sca_amount  : arg4,
            timestamp      : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&arg0.mint_records, arg1)) {
            let v1 = 0x2::table::new<0x2::object::ID, MintRecord>(arg6);
            0x2::table::add<0x2::object::ID, MintRecord>(&mut v1, arg2, v0);
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&mut arg0.mint_records, arg1, v1);
        } else {
            0x2::table::add<0x2::object::ID, MintRecord>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&mut arg0.mint_records, arg1), arg2, v0);
        };
    }

    public fun add_to_mint_records(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&arg1.mint_records, arg2)) {
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&mut arg1.mint_records, arg2, 0x2::table::new<0x2::object::ID, MintRecord>(arg3));
        };
    }

    fun assert_domain_exists(arg0: &DomainKiosk) {
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain), 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::domain_not_exists());
    }

    fun assert_domain_not_exists(arg0: &DomainKiosk) {
        assert!(0x1::option::is_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain), 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::domain_exists());
    }

    fun assert_user_and_ve_sca_key(arg0: &DomainKiosk, arg1: address, arg2: 0x2::object::ID) {
        assert!(0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&arg0.mint_records, arg1), 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::user_not_in_mint_records());
        assert!(!0x2::table::contains<0x2::object::ID, MintRecord>(0x2::table::borrow<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&arg0.mint_records, arg1), arg2), 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::ve_sca_key_already_used_for_minting());
    }

    fun assert_ve_sca_amount_threshold(arg0: &Config, arg1: 0x2::object::ID, arg2: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(arg1, arg2, arg3);
        assert!(v0 >= arg0.ve_sca_amount_threshold, 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::ve_sca_amount_threshold_not_met());
        v0
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::version_mismatch());
    }

    public fun get_global_mint_access(arg0: &Config) : bool {
        arg0.allow_mint
    }

    public fun get_total_minted(arg0: &DomainKiosk) : u64 {
        arg0.total_minted
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                      : 0x2::object::new(arg0),
            version                 : 1,
            allow_mint              : false,
            ve_sca_amount_threshold : 0,
        };
        let v1 = DomainKiosk{
            id           : 0x2::object::new(arg0),
            domain       : 0x1::option::none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(),
            mint_records : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(arg0),
            total_minted : 0,
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::share_object<DomainKiosk>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun mint_subdomain(arg0: &mut DomainKiosk, arg1: &Config, arg2: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg4: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration {
        assert_version(arg1);
        assert!(arg1.allow_mint, 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::global_mint_access_denied());
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg2);
        assert_user_and_ve_sca_key(arg0, v0, v1);
        let v2 = assert_ve_sca_amount_threshold(arg1, v1, arg3, arg6);
        add_mint_record(arg0, v0, v1, arg5, v2, arg6, arg7);
        let v3 = 0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain);
        let v4 = 0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new(arg4, v3, arg6, arg5, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(v3), false, false, arg7);
        let v5 = SubDomainMintedEvent{
            parent_id           : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v3),
            subdomain_object_id : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration>(&v4),
            subdomain_name      : arg5,
            timestamp           : 0x2::clock::timestamp_ms(arg6) / 1000,
            ve_sca_key          : v1,
            ve_sca_amount       : v2,
            user                : v0,
        };
        0x2::event::emit<SubDomainMintedEvent>(v5);
        arg0.total_minted = arg0.total_minted + 1;
        v4
    }

    public fun remove_batch_mint_records(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            remove_from_mint_records(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public fun remove_from_mint_records(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&arg1.mint_records, arg2)) {
            0x2::table::drop<0x2::object::ID, MintRecord>(0x2::table::remove<address, 0x2::table::Table<0x2::object::ID, MintRecord>>(&mut arg1.mint_records, arg2));
            let v0 = MintRecordRemoved{
                user   : arg2,
                sender : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<MintRecordRemoved>(v0);
        };
    }

    public fun set_global_mint_access(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.allow_mint = arg2;
    }

    public fun set_ve_sca_amount_threshold(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.ve_sca_amount_threshold = arg2;
        let v0 = AmountThresholdUpdated{
            old_threshold : arg1.ve_sca_amount_threshold,
            new_threshold : arg2,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AmountThresholdUpdated>(v0);
    }

    public fun take_domain(arg0: &AdminCap, arg1: &mut DomainKiosk, arg2: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert_domain_exists(arg1);
        let v0 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg1.domain);
        let v1 = DomainTaken{
            domain : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0),
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DomainTaken>(v1);
        v0
    }

    public fun upgrade_version(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > arg1.version, 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes::protocol_downgrade_not_allowed());
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}


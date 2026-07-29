module 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault_factory {
    struct FactoryAdminCap has store, key {
        id: 0x2::object::UID,
        factory_id: 0x2::object::ID,
    }

    struct VaultRecord has copy, drop, store {
        request_id: u64,
        vault_id: 0x2::object::ID,
    }

    struct LendingVaultFactory has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        next_vault_nonce: u64,
        records: vector<VaultRecord>,
    }

    public fun accept_admin(arg0: &mut LendingVaultFactory, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::option::is_some<address>(&arg0.pending_admin), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        let v0 = *0x1::option::borrow<address>(&arg0.pending_admin);
        assert!(0x2::tx_context::sender(arg2) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_transferred(0x2::object::id<LendingVaultFactory>(arg0), arg0.admin, v0, 0x2::clock::timestamp_ms(arg1));
    }

    fun assert_version(arg0: &LendingVaultFactory) {
        assert!(arg0.version == 1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::wrong_version());
    }

    public fun create_factory(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : FactoryAdminCap {
        let v0 = LendingVaultFactory{
            id               : 0x2::object::new(arg1),
            version          : 1,
            admin            : arg0,
            pending_admin    : 0x1::option::none<address>(),
            next_vault_nonce : 1,
            records          : 0x1::vector::empty<VaultRecord>(),
        };
        0x2::transfer::share_object<LendingVaultFactory>(v0);
        FactoryAdminCap{
            id         : 0x2::object::new(arg1),
            factory_id : 0x2::object::id<LendingVaultFactory>(&v0),
        }
    }

    public fun create_lending_vault_for_request<T0, T1, T2: key>(arg0: &mut LendingVaultFactory, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: u64, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0x2::coin_registry::Currency<T2>, arg5: 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::ShareRegistrationProof, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg0);
        let (v0, v1, v2) = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::consume_proof(arg5);
        let v3 = v2;
        let v4 = v1;
        assert!(v0 == 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg3), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::coin::total_supply<T2>(&arg3) == 0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::preminted_share_supply());
        let v5 = 0x2::coin_registry::name<T2>(arg4);
        let v6 = if (strings_equal(&v5, &v4)) {
            let v7 = 0x2::coin_registry::symbol<T2>(arg4);
            strings_equal(&v7, &v3)
        } else {
            false
        };
        assert!(v6, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_share_metadata());
        let v8 = 0;
        while (v8 < 0x1::vector::length<VaultRecord>(&arg0.records)) {
            assert!(0x1::vector::borrow<VaultRecord>(&arg0.records, v8).request_id != arg2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
            v8 = v8 + 1;
        };
        create_lending_vault_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, v4, v3, arg6, arg7)
    }

    fun create_lending_vault_impl<T0, T1, T2: key>(arg0: &mut LendingVaultFactory, arg1: &mut 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::OfferBook, arg2: u64, arg3: 0x2::coin::TreasuryCap<T2>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_borrower(arg1, arg2);
        assert!(0x2::tx_context::sender(arg7) == v0, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v1 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal_token(arg1, arg2);
        let v2 = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_collateral_token(arg1, arg2);
        let (v3, v4) = 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::create_for_request<T0, T1, T2>(arg2, arg0.admin, v0, v1, v2, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_principal(arg1, arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_min_principal(arg1, arg2), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_created_at_ms(arg1, arg2) + 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::request_funding_window_secs(arg1, arg2) * 1000, arg3, arg7);
        let v5 = v3;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_offer_book::register_vault(arg1, arg2, 0x2::object::id_to_address(&v5));
        let v6 = VaultRecord{
            request_id : arg2,
            vault_id   : v5,
        };
        0x1::vector::push_back<VaultRecord>(&mut arg0.records, v6);
        arg0.next_vault_nonce = arg0.next_vault_nonce + 1;
        0x2::transfer::public_transfer<0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_lending_vault::VaultOperatorCap<T0, T1>>(v4, v0);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_factory_vault_created(arg2, v5, v1, v2, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
        v5
    }

    public fun factory_version(arg0: &LendingVaultFactory) : u64 {
        arg0.version
    }

    public fun get_admin(arg0: &LendingVaultFactory) : address {
        arg0.admin
    }

    public fun get_vault_count(arg0: &LendingVaultFactory) : u64 {
        0x1::vector::length<VaultRecord>(&arg0.records)
    }

    public fun get_vault_id_by_request(arg0: &LendingVaultFactory, arg1: u64) : 0x2::object::ID {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VaultRecord>(&arg0.records)) {
            let v1 = 0x1::vector::borrow<VaultRecord>(&arg0.records, v0);
            if (v1.request_id == arg1) {
                return v1.vault_id
            };
            v0 = v0 + 1;
        };
        abort 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::not_found()
    }

    public fun migrate(arg0: &mut LendingVaultFactory, arg1: &FactoryAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.factory_id == 0x2::object::id<LendingVaultFactory>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        let v0 = arg0.version;
        assert!(v0 < 1, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        if (v0 < 5) {
            arg0.pending_admin = 0x1::option::none<address>();
        };
        arg0.version = 1;
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_object_migrated(0x2::object::id<LendingVaultFactory>(arg0), v0, 1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun propose_admin(arg0: &mut LendingVaultFactory, arg1: &FactoryAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.factory_id == 0x2::object::id<LendingVaultFactory>(arg0), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::unauthorized());
        assert!(0x1::option::is_none<address>(&arg0.pending_admin), 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_errors::invalid_state());
        arg0.pending_admin = 0x1::option::some<address>(arg2);
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_events::emit_admin_proposed(0x2::object::id<LendingVaultFactory>(arg0), arg0.admin, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun register_share_treasury(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::ShareRegistrationProof {
        0xf3bf2059ce568d36bef50bf298d5c1d61db13461550c6d93208eec53ff9191a1::concord_share_metadata::mint_proof(arg0, arg1, arg2, arg3)
    }

    fun strings_equal(arg0: &0x1::string::String, arg1: &0x1::string::String) : bool {
        0x1::string::as_bytes(arg0) == 0x1::string::as_bytes(arg1)
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}


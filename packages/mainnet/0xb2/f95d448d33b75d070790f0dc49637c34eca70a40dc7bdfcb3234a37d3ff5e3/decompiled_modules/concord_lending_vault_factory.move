module 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_lending_vault_factory {
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
        next_vault_nonce: u64,
        records: vector<VaultRecord>,
    }

    fun assert_version(arg0: &LendingVaultFactory) {
        assert!(arg0.version == 3, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::wrong_version());
    }

    public fun create_factory(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : FactoryAdminCap {
        let v0 = LendingVaultFactory{
            id               : 0x2::object::new(arg1),
            version          : 3,
            admin            : arg0,
            next_vault_nonce : 1,
            records          : 0x1::vector::empty<VaultRecord>(),
        };
        0x2::transfer::share_object<LendingVaultFactory>(v0);
        FactoryAdminCap{
            id         : 0x2::object::new(arg1),
            factory_id : 0x2::object::id<LendingVaultFactory>(&v0),
        }
    }

    public fun create_lending_vault_for_request<T0, T1, T2: key>(arg0: &mut LendingVaultFactory, arg1: &mut 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: u64, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<VaultRecord>(&arg0.records)) {
            assert!(0x1::vector::borrow<VaultRecord>(&arg0.records, v0).request_id != arg2, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
            v0 = v0 + 1;
        };
        create_lending_vault_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun create_lending_vault_impl<T0, T1, T2: key>(arg0: &mut LendingVaultFactory, arg1: &mut 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::OfferBook, arg2: u64, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_borrower(arg1, arg2);
        assert!(0x2::tx_context::sender(arg5) == v0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        let (v1, v2) = 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_lending_vault::create_for_request<T0, T1, T2>(arg2, arg0.admin, v0, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_principal_token(arg1, arg2), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_collateral_token(arg1, arg2), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_principal(arg1, arg2), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_min_principal(arg1, arg2), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_created_at_ms(arg1, arg2) + 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::request_funding_window_secs(arg1, arg2) * 1000, arg3, arg5);
        let v3 = v1;
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_offer_book::register_vault(arg1, arg2, 0x2::object::id_to_address(&v3));
        let v4 = VaultRecord{
            request_id : arg2,
            vault_id   : v3,
        };
        0x1::vector::push_back<VaultRecord>(&mut arg0.records, v4);
        arg0.next_vault_nonce = arg0.next_vault_nonce + 1;
        0x2::transfer::public_transfer<0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_lending_vault::VaultOperatorCap<T0, T1>>(v2, v0);
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_factory_vault_created(arg2, v3, 0x2::clock::timestamp_ms(arg4));
        v3
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
        abort 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::not_found()
    }

    public fun migrate(arg0: &mut LendingVaultFactory, arg1: &FactoryAdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.factory_id == 0x2::object::id<LendingVaultFactory>(arg0), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        let v0 = arg0.version;
        assert!(v0 < 3, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::invalid_state());
        arg0.version = 3;
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_object_migrated(0x2::object::id<LendingVaultFactory>(arg0), v0, 3, 0x2::clock::timestamp_ms(arg2));
    }

    public fun set_admin(arg0: &mut LendingVaultFactory, arg1: &FactoryAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.factory_id == 0x2::object::id<LendingVaultFactory>(arg0), 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_errors::unauthorized());
        arg0.admin = arg2;
        0xb2f95d448d33b75d070790f0dc49637c34eca70a40dc7bdfcb3234a37d3ff5e3::concord_events::emit_admin_action(0x2::object::id<LendingVaultFactory>(arg0), 0x2::tx_context::sender(arg4), 11, 0x2::clock::timestamp_ms(arg3));
    }

    public fun version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}


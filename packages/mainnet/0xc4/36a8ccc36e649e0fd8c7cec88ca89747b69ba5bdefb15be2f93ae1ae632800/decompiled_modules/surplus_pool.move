module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::surplus_pool {
    struct SurplusInfo has drop, store {
        balance: u64,
        last_update_timestamp: u64,
    }

    struct SurplusPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        vault_registry_id: 0x2::object::ID,
        surplus_balance: 0x2::balance::Balance<T0>,
        surplus_map: 0x2::table::Table<0x2::object::ID, SurplusInfo>,
    }

    public fun assert_vault_registry_id<T0>(arg0: &SurplusPool<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.vault_registry_id == arg1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EVaultRegistryIdMismatch());
    }

    public fun assert_version<T0>(arg0: &SurplusPool<T0>) {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
    }

    public entry fun claim_surplus<T0>(arg0: 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin, arg1: &mut SurplusPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x2::object::id<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::VaultAdmin>(&arg0);
        if (0x2::table::contains<0x2::object::ID, SurplusInfo>(&arg1.surplus_map, v0)) {
            let v1 = 0x2::table::remove<0x2::object::ID, SurplusInfo>(&mut arg1.surplus_map, v0);
            let v2 = 0x2::balance::split<T0>(&mut arg1.surplus_balance, v1.balance);
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_claim_surplus_event(0x2::tx_context::sender(arg2), v0, 0x2::object::id<SurplusPool<T0>>(arg1), 0x2::balance::value<T0>(&v2));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), 0x2::tx_context::sender(arg2));
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::vault_admin::delete_vault_admin(arg0);
    }

    public(friend) fun create_surplus_pool<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SurplusPool<T0>{
            id                : 0x2::object::new(arg1),
            version           : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            vault_registry_id : arg0,
            surplus_balance   : 0x2::balance::zero<T0>(),
            surplus_map       : 0x2::table::new<0x2::object::ID, SurplusInfo>(arg1),
        };
        0x2::transfer::share_object<SurplusPool<T0>>(v0);
    }

    public fun get_surplus_balance<T0>(arg0: 0x2::object::ID, arg1: &SurplusPool<T0>) : u64 {
        if (0x2::table::contains<0x2::object::ID, SurplusInfo>(&arg1.surplus_map, arg0)) {
            0x2::table::borrow<0x2::object::ID, SurplusInfo>(&arg1.surplus_map, arg0).balance
        } else {
            0
        }
    }

    entry fun migrate<T0>(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut SurplusPool<T0>) {
        assert!(arg1.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENotUpgrade());
        arg1.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    public(friend) fun update_surplus<T0>(arg0: 0x2::object::ID, arg1: 0x2::balance::Balance<T0>, arg2: &mut SurplusPool<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (0x2::table::contains<0x2::object::ID, SurplusInfo>(&arg2.surplus_map, arg0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, SurplusInfo>(&mut arg2.surplus_map, arg0);
            v1.balance = v1.balance + 0x2::balance::value<T0>(&arg1);
            v1.last_update_timestamp = 0x2::clock::timestamp_ms(arg3);
            v0 = v1.balance;
        } else {
            let v2 = SurplusInfo{
                balance               : 0x2::balance::value<T0>(&arg1),
                last_update_timestamp : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::table::add<0x2::object::ID, SurplusInfo>(&mut arg2.surplus_map, arg0, v2);
        };
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_new_surplus_event(arg0, 0x2::object::id<SurplusPool<T0>>(arg2), 0x2::balance::value<T0>(&arg1), v0);
        0x2::balance::join<T0>(&mut arg2.surplus_balance, arg1);
    }

    // decompiled from Move bytecode v6
}


module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::fee_dispatcher {
    struct DispatcherRecord<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        vault_id: address,
        product_id: address,
        product_category: u64,
    }

    struct FeeDispatcherCreated<phantom T0> has copy, drop {
        id: address,
    }

    struct FeeDispatcher<phantom T0> has store, key {
        id: 0x2::object::UID,
        queue: 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::queue::FifoQueue<DispatcherRecord<T0>>,
    }

    public fun new<T0>(arg0: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = FeeDispatcher<T0>{
            id    : v0,
            queue : 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::queue::new<DispatcherRecord<T0>>(100, arg1),
        };
        let v2 = FeeDispatcherCreated<T0>{id: 0x2::object::uid_to_address(&v0)};
        0x2::event::emit<FeeDispatcherCreated<T0>>(v2);
        0x2::transfer::public_share_object<FeeDispatcher<T0>>(v1);
    }

    public(friend) fun add_record<T0>(arg0: &mut FeeDispatcher<T0>, arg1: address, arg2: u64, arg3: address, arg4: 0x2::balance::Balance<T0>) {
        let v0 = DispatcherRecord<T0>{
            balance          : arg4,
            vault_id         : arg3,
            product_id       : arg1,
            product_category : arg2,
        };
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::queue::insert<DispatcherRecord<T0>>(&mut arg0.queue, v0);
    }

    public entry fun dispatch<T0>(arg0: &mut FeeDispatcher<T0>, arg1: &0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::AssetRegistry, arg2: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::BalancesRegistry, arg3: &mut 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::Vault<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::queue::consume<DispatcherRecord<T0>>(&mut arg0.queue);
        0x1::vector::reverse<DispatcherRecord<T0>>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<DispatcherRecord<T0>>(&v0)) {
            let DispatcherRecord {
                balance          : v2,
                vault_id         : v3,
                product_id       : v4,
                product_category : v5,
            } = 0x1::vector::pop_back<DispatcherRecord<T0>>(&mut v0);
            let v6 = v2;
            let v7 = 0x2::object::id<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::Vault<T0>>(arg3);
            assert!(v3 == 0x2::object::id_to_address(&v7), 13906834453516255231);
            0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::add_fee_balance<T0>(arg3, arg1, arg2, v4, 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals::from_u64(0x2::balance::value<T0>(&v6), 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::decimals(0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::get_asset<T0>(arg1))));
            0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::vault::deposit_product_balance<T0>(arg3, arg1, arg2, v4, v6, v5, arg4, arg5);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<DispatcherRecord<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}


module 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::ops_buy_desk {
    struct OpsBuyDeskAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OpsBuyDesk has key {
        id: 0x2::object::UID,
        inventory: 0x2::balance::Balance<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>,
        sui_recipient: address,
        price_updater: address,
        pool_id: address,
        price_mist_sui_per_bten: u64,
        price_updated_ms: u64,
        paused: bool,
        total_sold_bten: u64,
        total_received_sui: u64,
    }

    struct OpsBuyDeskCreated has copy, drop {
        desk_id: address,
        sui_recipient: address,
        price_updater: address,
        pool_id: address,
        initial_price_mist_sui_per_bten: u64,
    }

    struct OpsBuyDeskDeposit has copy, drop {
        desk_id: address,
        amount: u64,
        inventory_after: u64,
    }

    struct OpsBuyDeskWithdraw has copy, drop {
        desk_id: address,
        amount: u64,
        inventory_after: u64,
    }

    struct OpsBuyDeskPriceUpdated has copy, drop {
        desk_id: address,
        price_mist_sui_per_bten: u64,
        updated_ms: u64,
        updater: address,
    }

    struct OpsBuyDeskPurchase has copy, drop {
        desk_id: address,
        buyer: address,
        sui_in: u64,
        bten_out: u64,
        price_mist_sui_per_bten: u64,
        pricing: u8,
        inventory_after: u64,
    }

    struct OpsBuyDeskPaused has copy, drop {
        desk_id: address,
        paused: bool,
    }

    fun apply_price(arg0: &mut OpsBuyDesk, arg1: u64, arg2: u64, arg3: address) {
        assert!(arg1 > 0, 6);
        arg0.price_mist_sui_per_bten = arg1;
        arg0.price_updated_ms = arg2;
        let v0 = 0x2::object::id<OpsBuyDesk>(arg0);
        let v1 = OpsBuyDeskPriceUpdated{
            desk_id                 : 0x2::object::id_to_address(&v0),
            price_mist_sui_per_bten : arg1,
            updated_ms              : arg2,
            updater                 : arg3,
        };
        0x2::event::emit<OpsBuyDeskPriceUpdated>(v1);
    }

    public fun bten_out_at_posted_price(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0, 6);
        let v0 = (arg0 as u128) * (100000000 as u128) / (arg1 as u128);
        assert!(v0 > 0, 1);
        assert!(v0 <= 18446744073709551615, 10);
        (v0 as u64)
    }

    public fun bten_out_at_sqrt_mid(arg0: u64, arg1: u128) : u64 {
        assert!(arg0 > 0, 3);
        assert!(arg1 > 0, 6);
        let v0 = ((arg0 as u256) << 128) / (arg1 as u256) * (arg1 as u256);
        assert!(v0 > 0, 1);
        assert!(v0 <= 18446744073709551615, 10);
        (v0 as u64)
    }

    public entry fun buy_with_sui(arg0: &mut OpsBuyDesk, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, 0x2::sui::SUI>>(arg1);
        assert!(0x2::object::id_to_address(&v0) == arg0.pool_id, 8);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 3);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, 0x2::sui::SUI>(arg1);
        settle_buy(arg0, arg2, v1, bten_out_at_sqrt_mid(v1, v2), arg3, price_mist_sui_per_bten_from_sqrt(v2), 0, arg4);
    }

    public entry fun buy_with_sui_posted_price(arg0: &mut OpsBuyDesk, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = arg0.price_mist_sui_per_bten;
        settle_buy(arg0, arg1, v0, bten_out_at_posted_price(v0, v1), arg2, v1, 1, arg3);
    }

    public entry fun create(arg0: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::RegistryAdminCap, arg1: address, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 7);
        assert!(arg2 != @0x0, 7);
        assert!(arg3 != @0x0, 7);
        assert!(arg4 != @0x0, 8);
        assert!(arg5 > 0, 6);
        let v0 = OpsBuyDesk{
            id                      : 0x2::object::new(arg6),
            inventory               : 0x2::balance::zero<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(),
            sui_recipient           : arg2,
            price_updater           : arg3,
            pool_id                 : arg4,
            price_mist_sui_per_bten : arg5,
            price_updated_ms        : 0,
            paused                  : false,
            total_sold_bten         : 0,
            total_received_sui      : 0,
        };
        let v1 = 0x2::object::id<OpsBuyDesk>(&v0);
        let v2 = OpsBuyDeskCreated{
            desk_id                         : 0x2::object::id_to_address(&v1),
            sui_recipient                   : arg2,
            price_updater                   : arg3,
            pool_id                         : arg4,
            initial_price_mist_sui_per_bten : arg5,
        };
        0x2::event::emit<OpsBuyDeskCreated>(v2);
        0x2::transfer::share_object<OpsBuyDesk>(v0);
        let v3 = OpsBuyDeskAdminCap{id: 0x2::object::new(arg6)};
        0x2::transfer::public_transfer<OpsBuyDeskAdminCap>(v3, arg1);
    }

    public entry fun deposit_bten(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: 0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>) {
        let v0 = 0x2::coin::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg2);
        assert!(v0 > 0, 1);
        0x2::balance::join<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&mut arg0.inventory, 0x2::coin::into_balance<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(arg2));
        let v1 = 0x2::object::id<OpsBuyDesk>(arg0);
        let v2 = OpsBuyDeskDeposit{
            desk_id         : 0x2::object::id_to_address(&v1),
            amount          : v0,
            inventory_after : 0x2::balance::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg0.inventory),
        };
        0x2::event::emit<OpsBuyDeskDeposit>(v2);
    }

    public fun inventory(arg0: &OpsBuyDesk) : u64 {
        0x2::balance::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg0.inventory)
    }

    public fun is_paused(arg0: &OpsBuyDesk) : bool {
        arg0.paused
    }

    public fun pool_id(arg0: &OpsBuyDesk) : address {
        arg0.pool_id
    }

    public fun price_mist_sui_per_bten(arg0: &OpsBuyDesk) : u64 {
        arg0.price_mist_sui_per_bten
    }

    public fun price_mist_sui_per_bten_from_sqrt(arg0: u128) : u64 {
        assert!(arg0 > 0, 6);
        let v0 = (arg0 as u256) * (arg0 as u256) * (100000000 as u256) >> 128;
        assert!(v0 > 0, 6);
        assert!(v0 <= 18446744073709551615, 10);
        (v0 as u64)
    }

    public fun price_updated_ms(arg0: &OpsBuyDesk) : u64 {
        arg0.price_updated_ms
    }

    public fun price_updater(arg0: &OpsBuyDesk) : address {
        arg0.price_updater
    }

    public entry fun set_paused(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = 0x2::object::id<OpsBuyDesk>(arg0);
        let v1 = OpsBuyDeskPaused{
            desk_id : 0x2::object::id_to_address(&v0),
            paused  : arg2,
        };
        0x2::event::emit<OpsBuyDeskPaused>(v1);
    }

    public entry fun set_pool_id(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: address) {
        assert!(arg2 != @0x0, 8);
        arg0.pool_id = arg2;
    }

    public entry fun set_price_mist_sui_per_bten(arg0: &mut OpsBuyDesk, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.price_updater, 9);
        apply_price(arg0, arg1, 0x2::clock::timestamp_ms(arg2), v0);
    }

    public entry fun set_price_mist_sui_per_bten_admin(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        apply_price(arg0, arg2, 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::sender(arg4));
    }

    public entry fun set_price_updater(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: address) {
        assert!(arg2 != @0x0, 7);
        arg0.price_updater = arg2;
    }

    public entry fun set_sui_recipient(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: address) {
        assert!(arg2 != @0x0, 7);
        arg0.sui_recipient = arg2;
    }

    fun settle_buy(arg0: &mut OpsBuyDesk, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg3 >= arg4, 4);
        assert!(arg3 <= 0x2::balance::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg0.inventory), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.sui_recipient);
        let v0 = 0x2::tx_context::sender(arg7);
        arg0.total_sold_bten = arg0.total_sold_bten + arg3;
        arg0.total_received_sui = arg0.total_received_sui + arg2;
        let v1 = 0x2::object::id<OpsBuyDesk>(arg0);
        let v2 = OpsBuyDeskPurchase{
            desk_id                 : 0x2::object::id_to_address(&v1),
            buyer                   : v0,
            sui_in                  : arg2,
            bten_out                : arg3,
            price_mist_sui_per_bten : arg5,
            pricing                 : arg6,
            inventory_after         : 0x2::balance::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg0.inventory),
        };
        0x2::event::emit<OpsBuyDeskPurchase>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(0x2::coin::from_balance<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(0x2::balance::split<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&mut arg0.inventory, arg3), arg7), v0);
    }

    public fun sui_recipient(arg0: &OpsBuyDesk) : address {
        arg0.sui_recipient
    }

    public fun total_received_sui(arg0: &OpsBuyDesk) : u64 {
        arg0.total_received_sui
    }

    public fun total_sold_bten(arg0: &OpsBuyDesk) : u64 {
        arg0.total_sold_bten
    }

    public fun unit() : u64 {
        100000000
    }

    public entry fun withdraw_bten(arg0: &mut OpsBuyDesk, arg1: &OpsBuyDeskAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(arg2 <= 0x2::balance::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg0.inventory), 5);
        let v0 = 0x2::object::id<OpsBuyDesk>(arg0);
        let v1 = OpsBuyDeskWithdraw{
            desk_id         : 0x2::object::id_to_address(&v0),
            amount          : arg2,
            inventory_after : 0x2::balance::value<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&arg0.inventory),
        };
        0x2::event::emit<OpsBuyDeskWithdraw>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(0x2::coin::from_balance<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(0x2::balance::split<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>(&mut arg0.inventory, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}


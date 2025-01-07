module 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager {
    struct PoolAdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_pool<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::create_pool<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<address>(0x2::tx_context::sender(arg8)), arg5, arg6, arg7, arg8);
    }

    public(friend) fun update_pool_status<T0>(arg0: &mut 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::Pool<T0>, arg1: u8) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::update_pool_status<T0>(arg0, arg1);
    }

    fun create_pool_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : PoolAdminCap {
        PoolAdminCap{id: 0x2::object::new(arg0)}
    }

    fun distribute_and_reset_pool<T0>(arg0: &mut 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::Pool<T0>, arg1: 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::WinerPoolTicket, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::distribute_pool<T0>(arg0, arg1, arg3);
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::reset_pool<T0>(arg0, arg2);
    }

    public(friend) fun mint_pool_admin_cap_and_take(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pool_admin_cap(arg0);
        0x2::transfer::transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun settle_pool<T0>(arg0: &mut 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::Pool<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::get_sold_cap<T0>(arg0) == 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::get_max_cap<T0>(arg0) || v0 > 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::get_end_time<T0>(arg0)) {
            let v1 = 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::get_tickets<T0>(arg0);
            let v2 = 0x2::table_vec::length<0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::PoolTicket>(v1);
            let v3 = 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::drand_lib::derive_randomness(arg1);
            let v4 = 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::copy_pool_ticket(0x2::table_vec::borrow<0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::PoolTicket>(v1, 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::drand_lib::safe_selection(v2, &v3)));
            0x1::debug::print<0x2::table_vec::TableVec<0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::PoolTicket>>(v1);
            0x1::debug::print<u64>(&v2);
            0x1::debug::print<0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::WinerPoolTicket>(&v4);
            distribute_and_reset_pool<T0>(arg0, v4, v0, arg3);
        };
    }

    // decompiled from Move bytecode v6
}


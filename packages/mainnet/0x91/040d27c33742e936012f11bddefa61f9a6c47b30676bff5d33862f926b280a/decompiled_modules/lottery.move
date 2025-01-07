module 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::lottery {
    struct LOTTERY has drop {
        dummy_field: bool,
    }

    public entry fun buy_ticket<T0>(arg0: &mut 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::buy_ticket<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_pool<T0>(arg0: &0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager::PoolAdminCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager::create_pool<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun init(arg0: LOTTERY, arg1: &mut 0x2::tx_context::TxContext) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager::mint_pool_admin_cap_and_take(arg1);
    }

    public entry fun settle_pool<T0>(arg0: &mut 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::Pool<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager::settle_pool<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_pool_status<T0>(arg0: &0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager::PoolAdminCap, arg1: &mut 0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool::Pool<T0>, arg2: u8) {
        0x91040d27c33742e936012f11bddefa61f9a6c47b30676bff5d33862f926b280a::pool_manager::update_pool_status<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


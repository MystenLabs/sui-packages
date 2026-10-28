module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint {
    public fun admin_void<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: address, arg4: u64, arg5: u64, arg6: u8, arg7: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg1, arg0);
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::admin_void<T0, T1>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun bucket_count<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::bucket_count<T0, T1>(arg0, arg1)
    }

    public fun entries<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : (vector<u64>, vector<u64>) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::entries<T0, T1>(arg0, arg1)
    }

    public fun exit_early<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::exit_early<T0, T1>(&v0, arg0, arg1, arg2)
    }

    public fun exit_early_bounded<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x2::clock::Clock, arg2: vector<u64>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::exit_early_bounded<T0, T1>(&v0, arg0, arg1, arg2, arg3, arg4)
    }

    public fun forfeits<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::forfeits<T0, T1>(arg0)
    }

    public fun lock<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::lock<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun lock_loss<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::lock_loss<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun lock_ms() : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::lock_ms()
    }

    public fun lock_reserved<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::Part>, arg6: vector<0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::EpochBasis>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::lock_reserved<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun locked_balance<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::locked_balance<T0, T1>(arg0, arg1)
    }

    public fun max_buckets() : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::max_buckets()
    }

    public fun next_unlock_ms<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::next_unlock_ms<T0, T1>(arg0, arg1, arg2)
    }

    public fun parts_total(arg0: &vector<0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::Part>) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::parts_total(arg0)
    }

    public fun releasable<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::releasable<T0, T1>(arg0, arg1, arg2)
    }

    public fun release_unlocked<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::release_unlocked<T0, T1>(&v0, arg0, arg1, arg2, arg3)
    }

    public fun reserve<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::reserve<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun reserved<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::reserved<T0>(arg0, arg1)
    }

    public fun take_forfeits<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink) : 0x2::balance::Balance<T1> {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x2::object::id<0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::StakingSink>(arg1);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::take_forfeits<T0, T1>(&v0, arg0)
    }

    public fun take_reserve<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) : (vector<0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::Part>, vector<0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::EpochBasis>) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::take_reserve<T0>(arg0, arg1, arg2, arg3)
    }

    public fun vest_ms() : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::vest_ms()
    }

    public fun vest_status<T0, T1>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u64) : (u64, u64, u64, u64, u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::locked_mint::vest_status<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}


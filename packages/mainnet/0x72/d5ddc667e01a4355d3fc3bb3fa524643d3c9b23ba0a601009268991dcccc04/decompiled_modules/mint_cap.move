module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::mint_cap {
    public fun default_debt_cap() : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::default_debt_cap()
    }

    public fun default_floor() : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::default_floor()
    }

    public fun epoch_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: u64) : u128 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::epoch_loss<T0>(arg0, arg1)
    }

    public fun epoch_of(arg0: u64) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::epoch_of(arg0)
    }

    public fun epoch_status<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: u64) : (u128, u128, u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::epoch_status<T0>(arg0, arg1)
    }

    public fun finalize_epoch<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x2::clock::Clock) : bool {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::finalize_epoch<T0>(&v0, arg0, arg1)
    }

    public fun note_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_loss<T0>(arg0, arg1, arg2, arg3);
    }

    public fun note_mint<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_mint<T0>(arg0, arg1, arg2, arg3);
    }

    public fun note_pnl<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64, arg4: u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::note_pnl<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun params<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : (u64, u64, u64, u128) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::params<T0>(arg0)
    }

    public fun params_v2<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : (u64, u64, u64, u128, u64, u64, u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::params_v2<T0>(arg0)
    }

    public fun scale_of<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: u64) : (bool, u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::scale_of<T0>(arg0, arg1)
    }

    public fun set_params<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg1, arg0);
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::set_params<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_params_v2<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg2);
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg1, arg0);
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::set_params_v2<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun unnote_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::unnote_loss<T0>(arg0, arg1, arg2, arg3)
    }

    public fun unnote_mint<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap::unnote_mint<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}


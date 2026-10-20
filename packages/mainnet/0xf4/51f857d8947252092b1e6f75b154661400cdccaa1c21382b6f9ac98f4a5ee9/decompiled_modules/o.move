module 0xf451f857d8947252092b1e6f75b154661400cdccaa1c21382b6f9ac98f4a5ee9::o {
    public fun ab<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        abm<T0, T1>(arg0, arg1, arg2, 0, arg3)
    }

    public fun abm<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg4);
        let (v0, v1) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::swap_x_for_y<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun ba<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, T1>(arg0, arg1, arg2, 0, arg3)
    }

    public fun bam<T0, T1>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let (v0, v1) = 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::swap_y_for_x<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T1>(arg2, arg4), 0, arg3, arg4);
        0x2::coin::destroy_zero<T1>(v0);
        0x2::coin::into_balance<T0>(v1)
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 0, arg3)
    }

    public fun sxm<T0>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun xs<T0>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        abm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 0, arg3)
    }

    public fun xsm<T0>(arg0: &0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config::Config, arg1: &mut 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        abm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}


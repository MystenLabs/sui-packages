module 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_coin_treasury {
    struct SamTreasury<phantom T0> has store {
        cap: 0x2::coin::TreasuryCap<T0>,
    }

    public(friend) fun inner<T0>(arg0: &SamTreasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        &arg0.cap
    }

    public(friend) fun inner_mut<T0>(arg0: &mut SamTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.cap
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>) : SamTreasury<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 5);
        SamTreasury<T0>{cap: arg0}
    }

    // decompiled from Move bytecode v7
}


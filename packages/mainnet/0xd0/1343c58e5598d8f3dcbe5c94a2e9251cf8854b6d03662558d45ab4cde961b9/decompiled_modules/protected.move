module 0xd01343c58e5598d8f3dcbe5c94a2e9251cf8854b6d03662558d45ab4cde961b9::protected {
    struct ProtectedLendingMarket<phantom T0> {
        lending_market: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>,
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut ProtectedLendingMarket<T0>) : &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0> {
        &mut arg0.lending_market
    }

    public fun protect<T0>(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : ProtectedLendingMarket<T0> {
        ProtectedLendingMarket<T0>{lending_market: arg0}
    }

    public fun unprotect_and_reshare<T0>(arg0: ProtectedLendingMarket<T0>) {
        let ProtectedLendingMarket { lending_market: v0 } = arg0;
        0x2::transfer::public_share_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}


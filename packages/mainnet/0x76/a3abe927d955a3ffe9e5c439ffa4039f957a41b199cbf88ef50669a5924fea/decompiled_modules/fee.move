module 0x76a3abe927d955a3ffe9e5c439ffa4039f957a41b199cbf88ef50669a5924fea::fee {
    public fun take_fee(arg0: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0) * arg1 / 10000, arg2), @0x1875dc4f41e2b62bbd2f62e95c10126725d3d2e4694fff854367e12ad5b52788);
    }

    // decompiled from Move bytecode v6
}


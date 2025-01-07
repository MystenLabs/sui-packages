module 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::query {
    struct QueryReserve<phantom T0> has copy, drop {
        value: u64,
    }

    struct QueryStake has copy, drop {
        staked: u64,
        reward: u64,
    }

    public entry fun query_reserve<T0>(arg0: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust) {
        let v0 = QueryReserve<T0>{value: 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::reserve::query<T0>(arg0)};
        0x2::event::emit<QueryReserve<T0>>(v0);
    }

    public entry fun query_stake(arg0: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::stake::query(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        let v2 = QueryStake{
            staked : v0,
            reward : v1,
        };
        0x2::event::emit<QueryStake>(v2);
    }

    // decompiled from Move bytecode v6
}


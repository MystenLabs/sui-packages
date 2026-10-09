module 0x68c51220e3e5037f63c5f3c928f25f178ddb4ae991619a14de52cce7f5e8e9d5::sale_tokens {
    struct SALE_A has key {
        id: 0x2::object::UID,
    }

    struct SALE_B has key {
        id: 0x2::object::UID,
    }

    struct SALE_C has key {
        id: 0x2::object::UID,
    }

    struct SALE_D has key {
        id: 0x2::object::UID,
    }

    struct SALE_E has key {
        id: 0x2::object::UID,
    }

    struct SALE_F has key {
        id: 0x2::object::UID,
    }

    struct SALE_G has key {
        id: 0x2::object::UID,
    }

    struct SALE_H has key {
        id: 0x2::object::UID,
    }

    struct SALE_I has key {
        id: 0x2::object::UID,
    }

    struct SALE_J has key {
        id: 0x2::object::UID,
    }

    struct SALE_K has key {
        id: 0x2::object::UID,
    }

    struct SALE_L has key {
        id: 0x2::object::UID,
    }

    struct SALE_M has key {
        id: 0x2::object::UID,
    }

    struct SALE_N has key {
        id: 0x2::object::UID,
    }

    struct SALE_O has key {
        id: 0x2::object::UID,
    }

    struct SALE_P has key {
        id: 0x2::object::UID,
    }

    struct SALE_Q has key {
        id: 0x2::object::UID,
    }

    struct SALE_R has key {
        id: 0x2::object::UID,
    }

    struct SALE_S has key {
        id: 0x2::object::UID,
    }

    struct SALE_T has key {
        id: 0x2::object::UID,
    }

    struct SALE_U has key {
        id: 0x2::object::UID,
    }

    struct SALE_V has key {
        id: 0x2::object::UID,
    }

    struct SALE_W has key {
        id: 0x2::object::UID,
    }

    struct SALE_X has key {
        id: 0x2::object::UID,
    }

    struct SALE_Y has key {
        id: 0x2::object::UID,
    }

    struct SALE_Z has key {
        id: 0x2::object::UID,
    }

    struct SALE_AA has key {
        id: 0x2::object::UID,
    }

    struct SALE_AB has key {
        id: 0x2::object::UID,
    }

    struct SALE_AC has key {
        id: 0x2::object::UID,
    }

    struct SALE_AD has key {
        id: 0x2::object::UID,
    }

    struct SALE_AE has key {
        id: 0x2::object::UID,
    }

    struct SALE_AF has key {
        id: 0x2::object::UID,
    }

    struct SALE_AG has key {
        id: 0x2::object::UID,
    }

    struct SALE_AH has key {
        id: 0x2::object::UID,
    }

    struct SALE_AI has key {
        id: 0x2::object::UID,
    }

    struct SALE_AJ has key {
        id: 0x2::object::UID,
    }

    struct SALE_AK has key {
        id: 0x2::object::UID,
    }

    struct SALE_AL has key {
        id: 0x2::object::UID,
    }

    struct SALE_AM has key {
        id: 0x2::object::UID,
    }

    struct SALE_AN has key {
        id: 0x2::object::UID,
    }

    struct SALE_LONG_SYMBOL has key {
        id: 0x2::object::UID,
    }

    public fun new_sale_a(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_A> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_A>(arg0, 9, 0x1::string::utf8(b"BPTA"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_A>(v0, arg1);
        v1
    }

    public fun new_sale_aa(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AA> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AA>(arg0, 9, 0x1::string::utf8(b"BPTAA"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AA>(v0, arg1);
        v1
    }

    public fun new_sale_ab(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AB> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AB>(arg0, 9, 0x1::string::utf8(b"BPTAB"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AB>(v0, arg1);
        v1
    }

    public fun new_sale_ac(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AC> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AC>(arg0, 9, 0x1::string::utf8(b"BPTAC"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AC>(v0, arg1);
        v1
    }

    public fun new_sale_ad(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AD> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AD>(arg0, 9, 0x1::string::utf8(b"BPTAD"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AD>(v0, arg1);
        v1
    }

    public fun new_sale_ae(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AE> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AE>(arg0, 9, 0x1::string::utf8(b"BPTAE"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AE>(v0, arg1);
        v1
    }

    public fun new_sale_af(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AF> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AF>(arg0, 9, 0x1::string::utf8(b"BPTAF"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AF>(v0, arg1);
        v1
    }

    public fun new_sale_ag(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AG> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AG>(arg0, 9, 0x1::string::utf8(b"BPTAG"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AG>(v0, arg1);
        v1
    }

    public fun new_sale_ah(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AH> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AH>(arg0, 9, 0x1::string::utf8(b"BPTAH"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AH>(v0, arg1);
        v1
    }

    public fun new_sale_ai(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AI> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AI>(arg0, 9, 0x1::string::utf8(b"BPTAI"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AI>(v0, arg1);
        v1
    }

    public fun new_sale_aj(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AJ> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AJ>(arg0, 9, 0x1::string::utf8(b"BPTAJ"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AJ>(v0, arg1);
        v1
    }

    public fun new_sale_ak(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AK> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AK>(arg0, 9, 0x1::string::utf8(b"BPTAK"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AK>(v0, arg1);
        v1
    }

    public fun new_sale_al(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AL> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AL>(arg0, 9, 0x1::string::utf8(b"BPTAL"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AL>(v0, arg1);
        v1
    }

    public fun new_sale_am(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AM> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AM>(arg0, 9, 0x1::string::utf8(b"BPTAM"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AM>(v0, arg1);
        v1
    }

    public fun new_sale_an(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_AN> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_AN>(arg0, 9, 0x1::string::utf8(b"BPTAN"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_AN>(v0, arg1);
        v1
    }

    public fun new_sale_b(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_B> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_B>(arg0, 9, 0x1::string::utf8(b"BPTB"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_B>(v0, arg1);
        v1
    }

    public fun new_sale_c(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_C> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_C>(arg0, 9, 0x1::string::utf8(b"BPTC"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_C>(v0, arg1);
        v1
    }

    public fun new_sale_d(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_D> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_D>(arg0, 9, 0x1::string::utf8(b"BPTD"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_D>(v0, arg1);
        v1
    }

    public fun new_sale_e(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_E> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_E>(arg0, 9, 0x1::string::utf8(b"BPTE"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_E>(v0, arg1);
        v1
    }

    public fun new_sale_f(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_F> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_F>(arg0, 9, 0x1::string::utf8(b"BPTF"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_F>(v0, arg1);
        v1
    }

    public fun new_sale_g(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_G> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_G>(arg0, 9, 0x1::string::utf8(b"BPTG"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_G>(v0, arg1);
        v1
    }

    public fun new_sale_h(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_H> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_H>(arg0, 9, 0x1::string::utf8(b"BPTH"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_H>(v0, arg1);
        v1
    }

    public fun new_sale_i(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_I> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_I>(arg0, 9, 0x1::string::utf8(b"BPTI"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_I>(v0, arg1);
        v1
    }

    public fun new_sale_j(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_J> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_J>(arg0, 9, 0x1::string::utf8(b"BPTJ"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_J>(v0, arg1);
        v1
    }

    public fun new_sale_k(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_K> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_K>(arg0, 9, 0x1::string::utf8(b"BPTK"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_K>(v0, arg1);
        v1
    }

    public fun new_sale_l(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_L> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_L>(arg0, 9, 0x1::string::utf8(b"BPTL"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_L>(v0, arg1);
        v1
    }

    public fun new_sale_long_symbol(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_LONG_SYMBOL> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_LONG_SYMBOL>(arg0, 9, 0x1::string::utf8(b"BPTLONGSYMBOLXXXXXXXXXXXXXXXXXXXX"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_LONG_SYMBOL>(v0, arg1);
        v1
    }

    public fun new_sale_m(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_M> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_M>(arg0, 9, 0x1::string::utf8(b"BPTM"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_M>(v0, arg1);
        v1
    }

    public fun new_sale_n(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_N> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_N>(arg0, 9, 0x1::string::utf8(b"BPTN"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_N>(v0, arg1);
        v1
    }

    public fun new_sale_o(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_O> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_O>(arg0, 9, 0x1::string::utf8(b"BPTO"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_O>(v0, arg1);
        v1
    }

    public fun new_sale_p(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_P> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_P>(arg0, 9, 0x1::string::utf8(b"BPTP"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_P>(v0, arg1);
        v1
    }

    public fun new_sale_q(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_Q> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_Q>(arg0, 9, 0x1::string::utf8(b"BPTQ"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_Q>(v0, arg1);
        v1
    }

    public fun new_sale_r(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_R> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_R>(arg0, 9, 0x1::string::utf8(b"BPTR"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_R>(v0, arg1);
        v1
    }

    public fun new_sale_s(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_S> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_S>(arg0, 9, 0x1::string::utf8(b"BPTS"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_S>(v0, arg1);
        v1
    }

    public fun new_sale_t(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_T> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_T>(arg0, 9, 0x1::string::utf8(b"BPTT"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_T>(v0, arg1);
        v1
    }

    public fun new_sale_u(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_U> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_U>(arg0, 9, 0x1::string::utf8(b"BPTU"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_U>(v0, arg1);
        v1
    }

    public fun new_sale_v(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_V> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_V>(arg0, 9, 0x1::string::utf8(b"BPTV"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_V>(v0, arg1);
        v1
    }

    public fun new_sale_w(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_W> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_W>(arg0, 9, 0x1::string::utf8(b"BPTW"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_W>(v0, arg1);
        v1
    }

    public fun new_sale_x(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_X> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_X>(arg0, 9, 0x1::string::utf8(b"BPTX"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_X>(v0, arg1);
        v1
    }

    public fun new_sale_y(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_Y> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_Y>(arg0, 9, 0x1::string::utf8(b"BPTY"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_Y>(v0, arg1);
        v1
    }

    public fun new_sale_z(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<SALE_Z> {
        let (v0, v1) = 0x2::coin_registry::new_currency<SALE_Z>(arg0, 9, 0x1::string::utf8(b"BPTZ"), 0x1::string::utf8(b"Blast presale test token"), 0x1::string::utf8(b"Sale token for Blast presale mainnet tests."), 0x1::string::utf8(b""), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SALE_Z>(v0, arg1);
        v1
    }

    // decompiled from Move bytecode v7
}


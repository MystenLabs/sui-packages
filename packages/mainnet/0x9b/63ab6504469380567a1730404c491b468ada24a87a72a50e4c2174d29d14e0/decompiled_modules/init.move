module 0x9b63ab6504469380567a1730404c491b468ada24a87a72a50e4c2174d29d14e0::init {
    struct PoolCreationTicket<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityTreasury<T1>,
    }

    public fun create_pool<T0, T1: drop>(arg0: PoolCreationTicket<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let PoolCreationTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::create_pool<T0, T1>(v1, arg1)
    }

    public fun new_pool_creation_ticket<T0, T1: drop>(arg0: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityTreasury<T1>, arg1: &mut 0x2::tx_context::TxContext) : PoolCreationTicket<T0, T1> {
        PoolCreationTicket<T0, T1>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        }
    }

    // decompiled from Move bytecode v6
}


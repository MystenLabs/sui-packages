module 0xfa101048aa5f13870111a1030db5cae049722dfe640122a3dfc80013ab41367f::init {
    struct PoolCreationTicket<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::equity::EquityTreasury<T1>,
    }

    public fun create_pool<T0, T1: drop>(arg0: PoolCreationTicket<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        let PoolCreationTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::supply_pool::create_pool<T0, T1>(v1, arg1)
    }

    public fun new_pool_creation_ticket<T0, T1: drop>(arg0: 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::equity::EquityTreasury<T1>, arg1: &mut 0x2::tx_context::TxContext) : PoolCreationTicket<T0, T1> {
        PoolCreationTicket<T0, T1>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        }
    }

    // decompiled from Move bytecode v6
}


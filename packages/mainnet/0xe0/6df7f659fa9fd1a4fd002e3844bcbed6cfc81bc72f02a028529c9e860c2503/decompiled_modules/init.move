module 0xe06df7f659fa9fd1a4fd002e3844bcbed6cfc81bc72f02a028529c9e860c2503::init {
    struct PoolCreationTicket<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0x54e96a877b6ed36e953af673efbe82aaa260be3c16a668b4c89b8ee5eb312918::equity::EquityTreasury<T1>,
    }

    public fun create_pool<T0, T1: drop>(arg0: PoolCreationTicket<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        let PoolCreationTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x54e96a877b6ed36e953af673efbe82aaa260be3c16a668b4c89b8ee5eb312918::supply_pool::create_pool<T0, T1>(v1, arg1)
    }

    public fun new_pool_creation_ticket<T0, T1: drop>(arg0: 0x54e96a877b6ed36e953af673efbe82aaa260be3c16a668b4c89b8ee5eb312918::equity::EquityTreasury<T1>, arg1: &mut 0x2::tx_context::TxContext) : PoolCreationTicket<T0, T1> {
        PoolCreationTicket<T0, T1>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        }
    }

    // decompiled from Move bytecode v6
}


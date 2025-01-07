module 0x53677df4383287aa63b199bf28c6f89f9ddfedc7ca82aa5cb88181db87fdef9b::init {
    struct PoolCreationTicket<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury: 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::equity::EquityTreasury<T1>,
    }

    public fun create_pool<T0, T1: drop>(arg0: PoolCreationTicket<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::access::ActionRequest {
        let PoolCreationTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::supply_pool::create_pool<T0, T1>(v1, arg1)
    }

    public fun new_pool_creation_ticket<T0, T1: drop>(arg0: 0x210583b3e0a97aa0da941ad2c73b4ad82580e6097fcbbb699f279045db33d996::equity::EquityTreasury<T1>, arg1: &mut 0x2::tx_context::TxContext) : PoolCreationTicket<T0, T1> {
        PoolCreationTicket<T0, T1>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        }
    }

    // decompiled from Move bytecode v6
}


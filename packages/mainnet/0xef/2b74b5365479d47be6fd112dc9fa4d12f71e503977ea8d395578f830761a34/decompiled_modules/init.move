module 0xef2b74b5365479d47be6fd112dc9fa4d12f71e503977ea8d395578f830761a34::init {
    public fun initialize<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : (0xef2b74b5365479d47be6fd112dc9fa4d12f71e503977ea8d395578f830761a34::vault::Vault<T0, T1>, 0xef2b74b5365479d47be6fd112dc9fa4d12f71e503977ea8d395578f830761a34::vault::OwnerKey) {
        0xef2b74b5365479d47be6fd112dc9fa4d12f71e503977ea8d395578f830761a34::vault::initialize<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


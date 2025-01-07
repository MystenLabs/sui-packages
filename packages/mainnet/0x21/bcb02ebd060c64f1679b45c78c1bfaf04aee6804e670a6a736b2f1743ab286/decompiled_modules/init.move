module 0x21bcb02ebd060c64f1679b45c78c1bfaf04aee6804e670a6a736b2f1743ab286::init {
    public fun initialize<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : (0x21bcb02ebd060c64f1679b45c78c1bfaf04aee6804e670a6a736b2f1743ab286::vault::Vault<T0, T1>, 0x21bcb02ebd060c64f1679b45c78c1bfaf04aee6804e670a6a736b2f1743ab286::vault::OwnerKey) {
        0x21bcb02ebd060c64f1679b45c78c1bfaf04aee6804e670a6a736b2f1743ab286::vault::initialize<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


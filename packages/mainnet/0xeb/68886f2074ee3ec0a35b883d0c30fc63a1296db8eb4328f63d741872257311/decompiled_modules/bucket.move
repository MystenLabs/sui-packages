module 0xeb68886f2074ee3ec0a35b883d0c30fc63a1296db8eb4328f63d741872257311::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0xeb68886f2074ee3ec0a35b883d0c30fc63a1296db8eb4328f63d741872257311::profile::AdmincCap, arg1: &mut 0xeb68886f2074ee3ec0a35b883d0c30fc63a1296db8eb4328f63d741872257311::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xeb68886f2074ee3ec0a35b883d0c30fc63a1296db8eb4328f63d741872257311::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


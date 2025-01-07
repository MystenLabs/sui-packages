module 0xb0a2d66d1b353bf49e29f2aa413dc318e53cdc107fdbc3f2a159dd1abd097877::bucket {
    struct Bucket has drop {
        dummy_field: bool,
    }

    public fun register_dashboard(arg0: &0xb0a2d66d1b353bf49e29f2aa413dc318e53cdc107fdbc3f2a159dd1abd097877::profile::AdmincCap, arg1: &mut 0xb0a2d66d1b353bf49e29f2aa413dc318e53cdc107fdbc3f2a159dd1abd097877::profile::ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xb0a2d66d1b353bf49e29f2aa413dc318e53cdc107fdbc3f2a159dd1abd097877::profile::new_point_dashboard<Bucket>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


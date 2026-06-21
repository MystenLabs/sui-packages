module 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::walrus_adapter {
    public fun compute_new_end_epoch(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg2 > 0, 300);
        assert!(arg3 > 0, 302);
        let v0 = if (arg0 > arg1) {
            arg0
        } else {
            arg1
        };
        let v1 = v0 + arg2;
        assert!(v1 <= arg1 + arg3, 301);
        v1
    }

    public fun confirm_extension<T0>(arg0: &mut 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::vault::StorageVault<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::vault::record_blob_extension<T0>(arg0, arg1, compute_new_end_epoch(0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::vault::blob_end_epoch<T0>(arg0, arg1), arg2, arg3, arg4), arg5);
    }

    public fun default_renewal_threshold() : u64 {
        2
    }

    public fun is_renewal_due(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 <= arg1 + arg2
    }

    public fun mainnet_max_epochs_ahead() : u64 {
        53
    }

    // decompiled from Move bytecode v7
}


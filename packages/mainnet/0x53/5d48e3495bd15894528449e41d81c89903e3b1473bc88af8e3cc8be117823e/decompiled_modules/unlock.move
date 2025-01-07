module 0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::unlock {
    struct JoinPromise {
        item: 0x2::object::ID,
        burned: 0x2::object::ID,
        expected_balance: u64,
    }

    struct BurnPromise {
        expected_supply: u64,
    }

    public fun asset_from_kiosk_to_burn<T0>(arg0: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>, arg1: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongMetadata<T0>, arg2: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::proxy::ProtectedTP<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>, arg3: 0x2::transfer_policy::TransferRequest<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>, arg4: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) : BurnPromise {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg4, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::proxy::transfer_policy<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(arg2), arg3);
        assert!(0x2::object::id<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(arg0) == v0, 1);
        BurnPromise{expected_supply: 0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::supply<T0>(arg1) - 0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::value<T0>(arg0)}
    }

    public fun asset_from_kiosk_to_join<T0>(arg0: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>, arg1: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>, arg2: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::proxy::ProtectedTP<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>, arg3: 0x2::transfer_policy::TransferRequest<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>, arg4: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) : JoinPromise {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg4, 1);
        let (v0, _, _) = 0x2::transfer_policy::confirm_request<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::proxy::transfer_policy<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(arg2), arg3);
        let v3 = 0x2::object::id<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(arg1);
        assert!(v0 == v3, 1);
        JoinPromise{
            item             : 0x2::object::id<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(arg0),
            burned           : v3,
            expected_balance : 0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::value<T0>(arg0) + 0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::value<T0>(arg1),
        }
    }

    public fun prove_burn<T0>(arg0: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongMetadata<T0>, arg1: BurnPromise, arg2: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg2, 1);
        let BurnPromise { expected_supply: v0 } = arg1;
        assert!(0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::supply<T0>(arg0) == v0, 2);
    }

    public fun prove_join<T0>(arg0: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>, arg1: JoinPromise, arg2: 0x2::object::ID, arg3: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg3, 1);
        let JoinPromise {
            item             : v0,
            burned           : v1,
            expected_balance : v2,
        } = arg1;
        assert!(0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::value<T0>(arg0) == v2, 3);
        assert!(0x2::object::id<0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits::SongBit<T0>>(arg0) == v0, 4);
        assert!(arg2 == v1, 5);
    }

    // decompiled from Move bytecode v6
}


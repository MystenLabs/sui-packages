module 0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::balance_locker {
    public fun lock<T0, T1: drop>(arg0: &mut 0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::AssetLocker<0x2::balance::Balance<T0>, T1>, arg1: &mut T1, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::ascii::String, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::lock<0x2::balance::Balance<T0>, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = 0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::assets_of_mut<0x2::balance::Balance<T0>, T1>(arg0, arg1, arg2);
        let v1 = 1;
        while (v1 < 0x1::vector::length<0x2::balance::Balance<T0>>(v0)) {
            0x2::balance::join<T0>(0x1::vector::borrow_mut<0x2::balance::Balance<T0>>(v0, 0), 0x1::vector::pop_back<0x2::balance::Balance<T0>>(v0));
            v1 = v1 + 1;
        };
    }

    public fun new<T0, T1: drop>(arg0: &T1, arg1: &mut 0x2::tx_context::TxContext) : 0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::AssetLocker<0x2::balance::Balance<T0>, T1> {
        0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::new<0x2::balance::Balance<T0>, T1>(arg0, arg1)
    }

    public fun unlock<T0, T1: drop>(arg0: &mut 0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::AssetLocker<0x2::balance::Balance<T0>, T1>, arg1: &mut T1, arg2: address, arg3: u64, arg4: 0x1::ascii::String, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::unlock<0x2::balance::Balance<T0>, T1>(arg0, arg1, arg2, 0, arg4, arg5, arg6, arg7, arg8);
        0x1::vector::push_back<0x2::balance::Balance<T0>>(0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::assets_of_mut<0x2::balance::Balance<T0>, T1>(arg0, arg1, arg2), v0);
        0x2::balance::split<T0>(&mut v0, arg3)
    }

    public fun owner_locked_balance<T0, T1: drop>(arg0: &0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::AssetLocker<0x2::balance::Balance<T0>, T1>, arg1: address) : u64 {
        if (0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::has_assets<0x2::balance::Balance<T0>, T1>(arg0, arg1)) {
            0x2::balance::value<T0>(0x1::vector::borrow<0x2::balance::Balance<T0>>(0x3f92249f981cf28e61d84c100db311ea92dfde73fe0f9b8accfd184bbdc0e8b1::asset_locker::assets_of_unsafe<0x2::balance::Balance<T0>, T1>(arg0, arg1), 0))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}


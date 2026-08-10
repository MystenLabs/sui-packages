module 0x6412c60ec4abd4daba2e4b7f6696793ee2b4373108c086ece66cb7edaaf7acb8::drain {
    public entry fun collect<T0, T1>(arg0: &0x6412c60ec4abd4daba2e4b7f6696793ee2b4373108c086ece66cb7edaaf7acb8::owner::OwnerCap, arg1: &0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::CetusLpVault, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x8d1aee27f8537c06d19c16641f27008caafc42affd2d2fb7adb96919470481ec::bucketus::borrow_cetus_position(arg1), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}


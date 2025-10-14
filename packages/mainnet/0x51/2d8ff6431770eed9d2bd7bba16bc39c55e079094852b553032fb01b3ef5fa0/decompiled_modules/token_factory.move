module 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::token_factory {
    public fun create_and_launch<T0: drop>(arg0: T0, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::LaunchConfig, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, *0x1::string::bytes(&arg2), *0x1::string::bytes(&arg1), *0x1::string::bytes(&arg3), 0x1::option::none<0x2::url::Url>(), arg9);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v2 = 0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::create_token<T0>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::buy<T0>(&mut v2, arg7, 0, arg8, arg9), 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg7);
        };
        0x512d8ff6431770eed9d2bd7bba16bc39c55e079094852b553032fb01b3ef5fa0::bonding_curve::share_launch<T0>(v2);
    }

    // decompiled from Move bytecode v6
}


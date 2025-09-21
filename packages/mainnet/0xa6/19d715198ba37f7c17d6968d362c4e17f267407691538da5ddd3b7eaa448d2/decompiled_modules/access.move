module 0xa619d715198ba37f7c17d6968d362c4e17f267407691538da5ddd3b7eaa448d2::access {
    public fun payAccess(arg0: &mut 0xa619d715198ba37f7c17d6968d362c4e17f267407691538da5ddd3b7eaa448d2::admin::GalleryData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 0xa619d715198ba37f7c17d6968d362c4e17f267407691538da5ddd3b7eaa448d2::admin::get_fee(arg0), 1);
        0xa619d715198ba37f7c17d6968d362c4e17f267407691538da5ddd3b7eaa448d2::admin::handle_payment(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xa619d715198ba37f7c17d6968d362c4e17f267407691538da5ddd3b7eaa448d2::admin::get_fee(arg0), arg2), arg2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}


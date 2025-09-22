module 0xeecee5ff533368aee8982f39c6eae9bfbea162b299e5ec5a63adf79d3bd5a32f::access {
    public fun payAccess(arg0: &mut 0xeecee5ff533368aee8982f39c6eae9bfbea162b299e5ec5a63adf79d3bd5a32f::admin::GalleryData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 0xeecee5ff533368aee8982f39c6eae9bfbea162b299e5ec5a63adf79d3bd5a32f::admin::get_fee(arg0), 1);
        0xeecee5ff533368aee8982f39c6eae9bfbea162b299e5ec5a63adf79d3bd5a32f::admin::handle_payment(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0xeecee5ff533368aee8982f39c6eae9bfbea162b299e5ec5a63adf79d3bd5a32f::admin::get_fee(arg0), arg2), arg2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}


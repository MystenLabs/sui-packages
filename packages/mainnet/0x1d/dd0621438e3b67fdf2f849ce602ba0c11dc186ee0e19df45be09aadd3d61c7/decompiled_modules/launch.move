module 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::lending_market::create_lending_market<LAUNCH>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let v2 = v0;
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::lending_market::share_lending_market<LAUNCH>(&v2, v1);
        0x2::transfer::public_transfer<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::lending_market::LendingMarketOwnerCap<LAUNCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


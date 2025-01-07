module 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::launch {
    struct LAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::lending_market::create_lending_market<LAUNCH>(arg0, arg1);
        let v2 = v0;
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::lending_market::share_lending_market<LAUNCH>(&v2, v1);
        0x2::transfer::public_transfer<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::lending_market::LendingMarketOwnerCap<LAUNCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


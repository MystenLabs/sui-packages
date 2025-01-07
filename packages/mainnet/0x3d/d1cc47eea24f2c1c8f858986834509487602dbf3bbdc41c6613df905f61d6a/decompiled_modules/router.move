module 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::router {
    public entry fun deposit<T0>(arg0: &mut 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::DividendManager, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::utils::merge_coins<T0>(arg1, arg3);
        0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::deposit<T0>(arg0, &mut v0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun push_bonus<T0>(arg0: &0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::AdminCap, arg1: &mut 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::DividendManager) {
        0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::push_bonus<T0>(arg0, arg1);
    }

    public entry fun redeem<T0>(arg0: &mut 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::DividendManager, arg1: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::redeem<T0>(arg0, arg1, arg2);
    }

    public entry fun register_bonus<T0>(arg0: &0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::AdminCap, arg1: &mut 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::DividendManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::register_bonus<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun remove_bonus<T0>(arg0: &0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::AdminCap, arg1: &mut 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::DividendManager) {
        0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::remove_bonus<T0>(arg0, arg1);
    }

    public entry fun settle(arg0: &0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::SettleCap, arg1: &mut 0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::DividendManager, arg2: &0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64) {
        0x3dd1cc47eea24f2c1c8f858986834509487602dbf3bbdc41c6613df905f61d6a::dividend::settle(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}


module 0x1b9c4f6456da8d3a57f78fb477bdaa4b26b2f7e4972b108526a06bbfe643af97::dsw {
    public fun dc(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


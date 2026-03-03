module 0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::decimal {
    public fun register_decimals<T0>(arg0: &0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::DragonBallCollector, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::tx_context::TxContext) {
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_functional(arg0);
        0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::decimals_admin::register_decimals<T0>(0x62911c4cbd0b229cbc6dc6c0c1408563b1fc8896b1e774c71611aaa1e97dc28a::governance::lending_admin_cap(arg0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


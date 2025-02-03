module 0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::shared_auction {
    public entry fun create_auction<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::share_object<T0>(0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::create_auction<T0>(arg0, arg1));
    }

    public entry fun bid<T0: store + key>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::Auction<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::update_auction<T0>(arg1, 0x2::tx_context::sender(arg2), 0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg2);
    }

    public entry fun end_auction<T0: store + key>(arg0: &mut 0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::auction_owner<T0>(arg0), 1);
        0xe46fa50d3f6240bbbd906e0018a649fa0bb1b088614224412742769003507dcf::auction_lib::end_shared_auction<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


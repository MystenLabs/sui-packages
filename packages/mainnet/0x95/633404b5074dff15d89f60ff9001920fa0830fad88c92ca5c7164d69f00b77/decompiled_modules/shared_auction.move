module 0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::shared_auction {
    public entry fun create_auction<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::share_object<T0>(0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::create_auction<T0>(arg0, arg1));
    }

    public entry fun bid<T0: store + key>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::Auction<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::update_auction<T0>(arg1, 0x2::tx_context::sender(arg2), 0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg2);
    }

    public entry fun end_auction<T0: store + key>(arg0: &mut 0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::auction_owner<T0>(arg0), 1);
        0x95633404b5074dff15d89f60ff9001920fa0830fad88c92ca5c7164d69f00b77::auction_lib::end_shared_auction<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


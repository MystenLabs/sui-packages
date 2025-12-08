module 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::prediction_market_adapter {
    public fun receive_position<T0>(arg0: &mut 0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::Account, arg1: 0x2::transfer::Receiving<0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::position::Position<T0>>, arg2: &0x2::tx_context::TxContext) : 0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::position::Position<T0> {
        0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::assert_owner(arg0, arg2);
        0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::position::receive<T0>(0xc627c220bc34642faae375ff008c7b493f63bb6e1d094fee41bb3a57851d0762::account::extend(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}


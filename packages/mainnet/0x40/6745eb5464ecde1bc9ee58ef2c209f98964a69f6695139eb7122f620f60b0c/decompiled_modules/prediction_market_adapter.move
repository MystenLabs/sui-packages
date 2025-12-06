module 0x406745eb5464ecde1bc9ee58ef2c209f98964a69f6695139eb7122f620f60b0c::prediction_market_adapter {
    public fun receive_position<T0>(arg0: &mut 0x406745eb5464ecde1bc9ee58ef2c209f98964a69f6695139eb7122f620f60b0c::account::Account, arg1: 0x2::transfer::Receiving<0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::position::Position<T0>>, arg2: &0x2::tx_context::TxContext) : 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::position::Position<T0> {
        0x406745eb5464ecde1bc9ee58ef2c209f98964a69f6695139eb7122f620f60b0c::account::assert_owner(arg0, arg2);
        0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::position::receive<T0>(0x406745eb5464ecde1bc9ee58ef2c209f98964a69f6695139eb7122f620f60b0c::account::extend(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}


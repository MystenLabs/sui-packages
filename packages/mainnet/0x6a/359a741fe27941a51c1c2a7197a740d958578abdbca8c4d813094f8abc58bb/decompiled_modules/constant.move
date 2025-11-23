module 0x3cf0f95d4f85fe965b9dcf5a0ceb33deb94e37734ce02dd965e5fcfdfe285b15::constant {
    struct PriceTicketCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        price_ticket: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceTicket<T0>,
    }

    public fun get_price_voucher_cap<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceOracleConfig, arg2: &PriceTicketCap<T0>, arg3: &0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::State, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceVoucher<T0> {
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::sy::is_sy_bind<T0, T1>(arg3), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::sy_not_supported());
        0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::generate_price_voucher<T0>(arg0, arg1, &arg2.price_ticket, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_rational(100, 100), arg4)
    }

    public fun register_price_ticket_cap<T0: drop>(arg0: 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher::PriceTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceTicketCap<T0>{
            id           : 0x2::object::new(arg1),
            price_ticket : arg0,
        };
        0x2::transfer::share_object<PriceTicketCap<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}


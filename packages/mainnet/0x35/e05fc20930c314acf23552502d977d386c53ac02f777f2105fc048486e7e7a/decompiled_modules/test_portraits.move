module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits {
    struct NFT1 has drop {
        dummy_field: bool,
    }

    struct NFT2 has drop {
        dummy_field: bool,
    }

    struct Portrait<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    public fun add_field<T0>(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::Counter) {
        assert!(0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::package::version() == 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::version(arg1), 0);
        0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::add_field<T0>(arg1);
    }

    public fun mint_and_transfer<T0>(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: &mut 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::Counter, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::package::version() == 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::version(arg1), 0);
        0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::incr_counter<T0>(arg1);
        let v0 = Portrait<T0>{
            id          : 0x2::object::new(arg3),
            mint_number : 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::num_minted<T0>(arg1),
        };
        0x2::transfer::public_transfer<Portrait<T0>>(v0, arg2);
    }

    public fun mint_number<T0>(arg0: &Portrait<T0>) : u64 {
        arg0.mint_number
    }

    // decompiled from Move bytecode v6
}


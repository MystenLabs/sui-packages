module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::migrate {
    entry fun migrate(arg0: &0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap, arg1: 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::Counter, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::new_internal(arg2);
        0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::add_existing_assets<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT1>(&mut v0, 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::klaus_mueller_portrait_cnt(&arg1));
        0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::add_existing_assets<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::test_portraits::NFT2>(&mut v0, 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::hayden_michael_portrait_cnt(&arg1));
        0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::delete(arg1);
        0x2::transfer::public_share_object<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2::Counter>(v0);
    }

    // decompiled from Move bytecode v6
}


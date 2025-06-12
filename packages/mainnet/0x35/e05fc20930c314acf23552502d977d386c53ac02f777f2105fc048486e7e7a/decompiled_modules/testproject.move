module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::testproject {
    struct TESTPROJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTPROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TESTPROJECT>(arg0, arg1);
        0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::display::setup_display(&v0, arg1);
        0x2::transfer::public_transfer<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::AdminCap>(0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::cap::new(arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::Counter>(0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter::new(arg1));
    }

    // decompiled from Move bytecode v6
}


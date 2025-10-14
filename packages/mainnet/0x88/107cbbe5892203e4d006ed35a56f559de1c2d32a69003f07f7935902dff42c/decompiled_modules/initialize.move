module 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::initialize {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::roles::initialize(arg0);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::protocol::initialize(v0, v1, v2, arg0);
        0x88107cbbe5892203e4d006ed35a56f559de1c2d32a69003f07f7935902dff42c::sub_accounts::initialize(arg0);
    }

    // decompiled from Move bytecode v6
}


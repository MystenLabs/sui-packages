module 0xcd806298a092606eb4bb6394bf48af2eeca25934e68fd012de2855a54ca00504::lastobjectid {
    public fun derive_id(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = *0x2::tx_context::digest(arg1);
        0x1::vector::insert<u8>(&mut v0, 241, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, arg0);
        v0
    }

    public fun tx_digest(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = *0x2::tx_context::digest(arg0);
        0x1::vector::remove<u8>(&mut v0, 0);
        v0
    }

    // decompiled from Move bytecode v6
}


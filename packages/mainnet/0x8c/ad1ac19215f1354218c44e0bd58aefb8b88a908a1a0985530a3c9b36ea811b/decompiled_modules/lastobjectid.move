module 0x8cad1ac19215f1354218c44e0bd58aefb8b88a908a1a0985530a3c9b36ea811b::lastobjectid {
    public fun derive_id(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = *0x2::tx_context::digest(arg1);
        0x1::vector::insert<u8>(&mut v0, 241, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun tx_digest(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = *0x2::tx_context::digest(arg0);
        0x1::vector::remove<u8>(&mut v0, 0);
        v0
    }

    // decompiled from Move bytecode v6
}


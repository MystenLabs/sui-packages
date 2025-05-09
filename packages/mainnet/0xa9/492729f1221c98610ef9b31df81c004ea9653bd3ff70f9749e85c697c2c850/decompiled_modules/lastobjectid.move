module 0xa9492729f1221c98610ef9b31df81c004ea9653bd3ff70f9749e85c697c2c850::lastobjectid {
    public fun derive_id(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1), 0x2::tx_context::sender(arg1));
        let v0 = *0x2::tx_context::digest(arg1);
        0x1::vector::remove<u8>(&mut v0, 0);
        0x1::vector::insert<u8>(&mut v0, 241, 0);
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x2::hash::blake2b256(&v0)
    }

    public fun tx_digest(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = *0x2::tx_context::digest(arg0);
        0x1::vector::pop_back<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}


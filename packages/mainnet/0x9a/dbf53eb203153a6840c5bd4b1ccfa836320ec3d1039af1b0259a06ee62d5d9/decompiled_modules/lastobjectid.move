module 0x9adbf53eb203153a6840c5bd4b1ccfa836320ec3d1039af1b0259a06ee62d5d9::lastobjectid {
    public fun tx_digest(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::digest(arg0);
        let v1 = *v0;
        0x1::vector::remove<u8>(&mut v1, 0);
        *v0
    }

    // decompiled from Move bytecode v6
}


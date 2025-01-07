module 0xf475a7ee52660c5849758bc10cbdca95068873c14850d73c1bc5e4a1c28c535b::bytes32 {
    struct Bytes32 has copy, drop, store {
        data: vector<u8>,
    }

    public fun data(arg0: &Bytes32) : vector<u8> {
        arg0.data
    }

    public fun from_vector(arg0: vector<u8>) : Bytes32 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        Bytes32{data: arg0}
    }

    public fun into_vector(arg0: Bytes32) : vector<u8> {
        let Bytes32 { data: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}


module 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::parse {
    struct Message has drop {
        thisChainId: u64,
        thisContract: address,
        srcChainId: u64,
        txHash: 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::Bytes32,
        to: address,
        token: address,
        amount: u64,
        actualamont: u64,
    }

    public fun parse(arg0: vector<u8>) : Message {
        assert!(0x1::vector::length<u8>(&arg0) == 256, 0);
        let v0 = 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::cursor::new<u8>(arg0);
        0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::cursor::destroy_empty<u8>(v0);
        Message{
            thisChainId  : 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::to_u64_be(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::take_bytes(&mut v0)),
            thisContract : 0x2::address::from_bytes(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes::take_bytes(&mut v0, 32)),
            srcChainId   : 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::to_u64_be(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::take_bytes(&mut v0)),
            txHash       : 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::take_bytes(&mut v0),
            to           : 0x2::address::from_bytes(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes::take_bytes(&mut v0, 32)),
            token        : 0x2::address::from_bytes(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes::take_bytes(&mut v0, 32)),
            amount       : 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::to_u64_be(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::take_bytes(&mut v0)),
            actualamont  : 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::to_u64_be(0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::take_bytes(&mut v0)),
        }
    }

    public fun actualamont(arg0: &Message) : u64 {
        arg0.actualamont
    }

    public fun amount(arg0: &Message) : u64 {
        arg0.amount
    }

    public fun srcChainId(arg0: &Message) : u64 {
        arg0.srcChainId
    }

    public fun thisChainId(arg0: &Message) : u64 {
        arg0.thisChainId
    }

    public fun thisContract(arg0: &Message) : address {
        arg0.thisContract
    }

    public fun to(arg0: &Message) : address {
        arg0.to
    }

    public fun token(arg0: &Message) : address {
        arg0.token
    }

    public fun txHash(arg0: &Message) : 0x2c69b09633b147382a0e3f605714ea24530cb7eaa1d0f19a66eb73fdde291a60::bytes32::Bytes32 {
        arg0.txHash
    }

    // decompiled from Move bytecode v6
}


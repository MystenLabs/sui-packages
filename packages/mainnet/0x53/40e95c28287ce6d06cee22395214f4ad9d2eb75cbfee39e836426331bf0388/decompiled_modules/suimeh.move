module 0x5340e95c28287ce6d06cee22395214f4ad9d2eb75cbfee39e836426331bf0388::suimeh {
    struct SUIMEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEH, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIMEH>(arg0, 5977763085639096024, b"MEH ON SUI", b"SUIMEH", x"245355494d454820e280942074686520656d626f64696d656e74206f662061706174687920696e20746865206d656d6520636f696e20756e6976657273652c2074686520756c74696d6174652063727970746f20646567656e2c20656d6f74696f6e6c65737320696e207468652066616365206f66206368616f732e", b"https://images.hop.ag/ipfs/QmXtkFp5FxM3ZtEcjJTjmjy7TmP2hxxoTq9RL7LKKcLLNt", 0x1::string::utf8(b"https://x.com/_suimeh_"), 0x1::string::utf8(b"https://suimeh.xyz/"), 0x1::string::utf8(b"https://t.me/suimeh"), arg1);
    }

    // decompiled from Move bytecode v6
}


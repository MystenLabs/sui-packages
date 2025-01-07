module 0xea6b16ab38a0c234de4dd61706a5b68347a71aa0fc893c037aeb2ca5c109b03b::zenpai {
    struct ZENPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENPAI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<ZENPAI>(arg0, 362498905392112699, b"ZENPAI", b"ZENPAI", b"ZENAPI", b"https://images.hop.ag/ipfs/QmeTDvHxTzjKRwLx2puj4z7aTyVQBSmievfqCokiM2AgHD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


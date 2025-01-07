module 0xf1a9726c20dd9a7b9d07218cb0c094fe7a0f28b7c37472137489bfda3466bcb::pengsui {
    struct PENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PENGSUI>(arg0, 12465498520377341129, b"Penguin on Sui", b"PengSui", x"50656e6775696e732061726520612067726f7570206f66206171756174696320666c696768746c6573732062697264732066726f6d207468652066616d696c7920537068656e69736369646165206f6620746865206f7264657220537068656e69736369666f726d657320282f7366c9aacb886ec9aa73c99966c994cb90726d69cb907a2f292077697468207468652053756920646966666572656e63652e", b"https://images.hop.ag/ipfs/QmUJ1FhPpfDdUo7LWSg1inh4FtkJst61DVR3qCV3bJDsLY", 0x1::string::utf8(b"https://x.com/PengSui_"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/+_O4wV_SK6xUyMzc8"), arg1);
    }

    // decompiled from Move bytecode v6
}


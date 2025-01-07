module 0xa6f9a7d8080778d7bef14983a9e9cd9b9be4726a42eb0f9f6f053a245f71e8ec::pororo {
    struct PORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORORO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<PORORO>(arg0, 11146010560595952428, b"Pororo", b"PORORO", b"Pororo on sui", b"https://images.hop.ag/ipfs/QmaaCs4ohLt6PqrBQy3DsSFZKvzAzhi8ZVvmVBg8NxoVzJ", 0x1::string::utf8(b"https://x.com/Pororo_SUI"), 0x1::string::utf8(b"http://www.pororo.today"), 0x1::string::utf8(b"https://t.me/Pororo_SUI"), arg1);
    }

    // decompiled from Move bytecode v6
}


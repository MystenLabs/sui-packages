module 0xc46196faf219db898a3c7c7660ddb010993808dd1a5b37ab095517db49fd0931::screm {
    struct SCREM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SCREM>(arg0, 8376131023331029750, b"SCREM", b"SCREM", b"Birb screaming", b"https://images.hop.ag/ipfs/QmSgRZ6r7nrucdK65FKjzZ34tCirAreLWAsiSeHsGKByw1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


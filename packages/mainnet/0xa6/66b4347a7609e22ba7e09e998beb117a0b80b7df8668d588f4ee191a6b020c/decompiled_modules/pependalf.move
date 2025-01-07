module 0xa666b4347a7609e22ba7e09e998beb117a0b80b7df8668d588f4ee191a6b020c::pependalf {
    struct PEPENDALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPENDALF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PEPENDALF>(arg0, 1823944555419271984, b"Pepe Gendalf", b"PEPENDALF", b"Pepe Gendalf Coin.", b"https://images.hop.ag/ipfs/QmPBWJcdJUmcYEG9bU3okUzaRfDQcknxju3ki8tNhFocrP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


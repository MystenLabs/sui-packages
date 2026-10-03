module 0x8cf91562e090c6b6939e9dbb0a4b9b75ae470fcf672ae84e611a8ea76e730c86::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SEND>(arg0, 9, untag(b"SSEND"), untag(b"NSEND"), untag(b"D||{\"twitter\":\"https://x.com/suilendprotocol\",\"website\":\"https://suilend.fi/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidkuqpjnwrkhjksysb56ijxpt7ucml5sio3rddoywbkhq2lrddvte"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SEND>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SEND>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEND>>(0x2::coin::mint<SEND>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


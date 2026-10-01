module 0xecdde60e57e349e1752f774f897d9039d59c6a2114649dae6a84cd9ba4372898::suiloong {
    struct SUILOONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUILOONG>(arg0, 9, untag(b"SSUILOONG"), untag(b"NSUILOONG"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreihctfqz5vgmy4vtjmx6elwsxnx7ngwz4cjda5d2rcre37btmsyw5q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUILOONG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUILOONG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILOONG>>(0x2::coin::mint<SUILOONG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


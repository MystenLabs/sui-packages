module 0xdcab835eb99717609a56cf9950ac0b06b850463d9fc499717ebe03a2bc1d7bda::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AGI>(arg0, 9, untag(b"SAGI"), untag(b"Nartificial gooner intelligence"), untag(b"D||{\"website\":\"https://www.stonkfun.xyz/token/CaWZeUM4FvX9dPkjGc2xHS6tSN3qJfTWyvaG77aM5o7h\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreidof4edydpwipcorb5reuqid5cfvl234m3lnsi2sgpjyypddbeu4q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AGI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AGI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGI>>(0x2::coin::mint<AGI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


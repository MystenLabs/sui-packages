module 0x3913f7e3ad402c468f750fa1cc4be739a2c7d7dff9f11b4dce46403ec2f39999::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POP>(arg0, 9, untag(b"SPOP"), untag(b"NPOPULAR"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreigz53xocm3itlt2n7kdbaavdrikdp3lsydh2fkhkasmyynikb5zl4"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<POP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<POP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<POP>>(0x2::coin::mint<POP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


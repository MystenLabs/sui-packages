module 0x18e9f928b2e7c8fe5a5dc68f59ce604bce22582abd698c012bda2be97e07db6d::gor {
    struct GOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GOR>(arg0, 9, untag(b"SGOR"), untag(b"NGorbagana"), untag(b"D||{\"twitter\":\"https://x.com/Gorbagana_chain\",\"website\":\"https://gorbagana.wtf/\",\"telegram\":\"https://t.me/gorbagana_portal\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicjgonl6c2lfx7hxrdumzn3v5vtlzleb6fkzel7fqltzeblazjoki"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GOR>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GOR>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOR>>(0x2::coin::mint<GOR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


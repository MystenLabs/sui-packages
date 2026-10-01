module 0x8cd88c817ca720eab3583c188e8dfe283d13349912e8706108a4301254d5c413::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WOJAK>(arg0, 9, untag(b"SWOJAK"), untag(b"Nwojak"), untag(b"D||{\"twitter\":\"https://x.com/wojakcto\",\"website\":\"https://wojakcto.com/\",\"telegram\":\"https://t.me/wojakctoeth\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihsxkjcqzepr2qfweahgfcbr74slgfzvbgywoll3eijjw6gggeo54"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WOJAK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WOJAK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WOJAK>>(0x2::coin::mint<WOJAK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


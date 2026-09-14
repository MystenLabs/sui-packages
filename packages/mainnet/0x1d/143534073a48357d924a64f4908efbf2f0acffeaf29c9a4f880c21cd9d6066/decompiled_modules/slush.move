module 0x1d143534073a48357d924a64f4908efbf2f0acffeaf29c9a4f880c21cd9d6066::slush {
    struct SLUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SLUSH>(arg0, 9, untag(b"SSLUSH"), untag(b"NSlushCat"), untag(b"DSlushCat is the chillest cat on the blockchain. No stress, no drama, just endless slushies and good vibes"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiakbim7iao5cnfqy6nosnyeyv7qqfcny6wywllqukjhypr3kkxjby"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SLUSH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SLUSH>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLUSH>>(0x2::coin::mint<SLUSH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


module 0xf82f307cf2687efab82666e8843673e6f48b3d06af302cfad8603df85148d1c5::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ADENIYI>(arg0, 9, untag(b"SADENIYI"), untag(b"NThe Sui Bull"), untag(x"445945532c20692077696c6c20626520696e20746865207472656e63686573207769746820796f752067757973f09faa96f09f94a5"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreigcqmj4iu2cpnzcwi5v4re6ffyuqceclagx5m4rkpytq76zrakooi"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ADENIYI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ADENIYI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ADENIYI>>(0x2::coin::mint<ADENIYI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


module 0xbabbd014d14da2f003f2fdfcdaa8fa0bb28ca6dfae56f6d514da8f6b4328d842::sompi {
    struct SOMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SOMPI>(arg0, 9, untag(b"SSOMPI"), untag(b"NSompi"), untag(b"D||{\"twitter\":\"https://x.com/Sompi_kas\",\"website\":\"https://kas.fun/token/0xef3d3954eed2219f8bdd814ea38fc747783c7777\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreifb6hhg7dlltaganxutfxqcx73jlzsesgvbt6xm2l3zqzpwq5zhqu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SOMPI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SOMPI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SOMPI>>(0x2::coin::mint<SOMPI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


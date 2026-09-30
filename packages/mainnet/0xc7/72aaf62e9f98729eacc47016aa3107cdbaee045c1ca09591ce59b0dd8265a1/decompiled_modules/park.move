module 0xc772aaf62e9f98729eacc47016aa3107cdbaee045c1ca09591ce59b0dd8265a1::park {
    struct PARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PARK>(arg0, 9, untag(b"SPARK"), untag(b"NSTONKS PARK"), untag(b"D||{\"twitter\":\"https://x.com/stonkspark\",\"website\":\"https://stonkspark.fun/\",\"telegram\":\"https://t.me/StonksparkSOL\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreic6vzzqa7sv3wkfngtxqbqnn6in5pr3glx7v7xkh7t7tuntlxn2bq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PARK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PARK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PARK>>(0x2::coin::mint<PARK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


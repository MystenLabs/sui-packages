module 0x6d670cf4459f70c7e04fbfc807a1778250ae4ce12aa9e8258c543fb73acdad13::pwease {
    struct PWEASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PWEASE>(arg0, 9, untag(b"SPWEASE"), untag(b"NPwease"), untag(b"D||{\"twitter\":\"https://x.com/pweaseman\",\"website\":\"https://pweasetoken.com\",\"telegram\":\"https://t.me/pweaseman\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreic6hr2f4fpewe2vxge24gebbmxzvtsb3illztd4s3undc77egwkym"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PWEASE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PWEASE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PWEASE>>(0x2::coin::mint<PWEASE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


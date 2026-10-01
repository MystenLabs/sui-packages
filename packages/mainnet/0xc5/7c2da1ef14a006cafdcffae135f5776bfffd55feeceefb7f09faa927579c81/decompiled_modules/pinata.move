module 0xc57c2da1ef14a006cafdcffae135f5776bfffd55feeceefb7f09faa927579c81::pinata {
    struct PINATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PINATA>(arg0, 9, untag(b"SPinata"), untag(b"NPinata"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreiecv26hyb3btvedgza7s6gbqfbmn7l3qjjr36dfle2gq7zj5rk4je"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PINATA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PINATA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PINATA>>(0x2::coin::mint<PINATA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


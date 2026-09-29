module 0xe2d3efc37b687ce054da418820e727722c2f3fd353caef0204396886aef5ed36::aipopcat {
    struct AIPOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AIPOPCAT>(arg0, 9, 0x1::string::utf8(b"AIPOPCAT"), 0x1::string::utf8(b"Artificial Popcat"), 0x1::string::utf8(b"https://t.me/ArtificialPopcat_Meme"), 0x1::string::utf8(b"https://gateway.irys.xyz/zDtbRd9rJHcgKZrM5KMO4eMyCKTaTuOimYGCjih_HSk"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AIPOPCAT>>(0x2::coin::mint<AIPOPCAT>(&mut v2, 1000000000000000000, arg1), @0x90bf8f5b80757267a72f7afd9d52969b9398dbc9d5e2eda3a72a68c77500bff5);
        0x2::coin_registry::make_supply_fixed_init<AIPOPCAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AIPOPCAT>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}


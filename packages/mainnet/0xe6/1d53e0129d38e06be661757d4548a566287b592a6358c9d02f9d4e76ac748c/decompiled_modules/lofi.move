module 0xe61d53e0129d38e06be661757d4548a566287b592a6358c9d02f9d4e76ac748c::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LOFI>(arg0, 9, untag(b"SLOFI"), untag(b"NLOFI"), untag(b"D||{\"twitter\":\"https://x.com/lofitheyeti\",\"website\":\"https://lofitheyeti.com/\",\"telegram\":\"https://t.me/LofiOnSui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreid23hen7z7bavk6e632gzcybnskjaarukdlaf7htrb5spq5nxqyya"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<LOFI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LOFI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::mint<LOFI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


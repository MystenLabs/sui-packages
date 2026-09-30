module 0x7b49e6a0cfdf36eb5156594ab88735b29459a9def49b016b3ff747ad24fe8aff::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BLAST>(arg0, 9, untag(b"SBLAST"), untag(b"Nblast"), untag(b"DClear for launch.||{\"twitter\":\"https://x.com/blastdotfun\",\"website\":\"http://blast.fun\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreia7twq74il7cdgm2fdzvshp6gizapbf7os36tskmeedl4e5hbeiou"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BLAST>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BLAST>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLAST>>(0x2::coin::mint<BLAST>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


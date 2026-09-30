module 0xb48d27a31df635392b4f6c7eb5f8c5e003a0478a67e0112f07ad831a84dcd6d6::harmonic {
    struct HARMONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARMONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HARMONIC>(arg0, 9, untag(b"SHARMONIC"), untag(b"NHarmonic Agent"), untag(b"D||{\"twitter\":\"https://x.com/HarmonicAgents\",\"website\":\"https://harmonicagent.solutions/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigy6fwbka6jhrzhd6axtbtrmp4fheadgzbb5scl2upbeydewodx6i"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<HARMONIC>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HARMONIC>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HARMONIC>>(0x2::coin::mint<HARMONIC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


module 0x65f1e65deb8249e20cdba87fa0cd8c23a067f97cc6fcfbc504a76e3f9e758496::ept {
    struct EPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EPT>(arg0, 9, untag(b"SEPT"), untag(b"NEpoch"), untag(b"D||{\"twitter\":\"https://x.com/EpochSui\",\"website\":\"https://epochsui.com\",\"telegram\":\"https://t.me/epochnames\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicnwacr2oemoerykbg5gajcror243nsl3254zecuw7wxvmewmktlu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<EPT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<EPT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<EPT>>(0x2::coin::mint<EPT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


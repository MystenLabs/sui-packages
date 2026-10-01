module 0x72b8e3684bddf32af603d2cb0842cba7c227d2f48136073bf3d2652bf8386f5b::drb {
    struct DRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DRB>(arg0, 9, untag(b"SDRB"), untag(b"NDebtReliefBot"), untag(b"D||{\"twitter\":\"https://x.com/DRBTaskForce\",\"website\":\"https://bio.site/drbtaskforce\",\"telegram\":\"https://t.me/DebtReliefBotPortal\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreie4kmgtffycozky34cryoneunef27mlwlt2vkj6lsya66cccibiqu"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<DRB>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DRB>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DRB>>(0x2::coin::mint<DRB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


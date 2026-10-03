module 0x225856773975d80857afa304f7a6d4301c37ee36c63ee7b3624752083c6c8b84::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PURR>(arg0, 9, untag(b"SPURR"), untag(b"NPurr"), untag(b"D||{\"twitter\":\"https://x.com/Hyperintern\",\"website\":\"https://app.hyperliquid.xyz/trade/PURR/USDC\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreifrb6cqi372mnhxff7zvcoisfgdtc6w6yrtc63vchpyobkgclbxzm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PURR>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PURR>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PURR>>(0x2::coin::mint<PURR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


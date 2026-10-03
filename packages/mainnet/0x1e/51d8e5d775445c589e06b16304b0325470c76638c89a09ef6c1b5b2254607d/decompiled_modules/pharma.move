module 0x1e51d8e5d775445c589e06b16304b0325470c76638c89a09ef6c1b5b2254607d::pharma {
    struct PHARMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHARMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PHARMA>(arg0, 9, untag(b"SPHARMA"), untag(b"NPharmasui"), untag(b"D||{\"twitter\":\"https://x.com/pharmasui_\",\"website\":\"https://pharmasui.xyz/\",\"telegram\":\"https://t.me/pharmasui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihfievcqa3fdymoi3culmy5ia3lmjijetfxggvrokaxwje62fjo4u"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<PHARMA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PHARMA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PHARMA>>(0x2::coin::mint<PHARMA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


module 0x80182559ea656d1795f92442e1a97223409d520b6dfef11b289a8363fdb04ccf::ptbt2 {
    struct PTBT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTBT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PTBT2>(arg0, 0, 0x1::string::utf8(b"PTBT2"), 0x1::string::utf8(b"PTB Speed Test 2"), 0x1::string::utf8(b"testing combined finalize+immutable PTB take 2, safe to ignore"), 0x1::string::utf8(b"https://gateway.irys.xyz/6OmIuU0rsc9PfSfefYV-IKrzi5RqLVjrs_4l1-zbQpA"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PTBT2>>(0x2::coin::mint<PTBT2>(&mut v2, 1, arg1), @0xb1a93b4f54716aab7c5e3fb56986e00eb5438bdc6aeb36b1e9ec76672772304c);
        0x2::coin_registry::make_supply_fixed_init<PTBT2>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PTBT2>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}


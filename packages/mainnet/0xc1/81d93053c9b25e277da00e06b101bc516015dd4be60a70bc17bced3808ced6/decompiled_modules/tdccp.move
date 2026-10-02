module 0xc181d93053c9b25e277da00e06b101bc516015dd4be60a70bc17bced3808ced6::tdccp {
    struct TDCCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDCCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TDCCP>(arg0, 9, untag(b"STDCCP"), untag(b"NTDCCP"), untag(b"D||{\"twitter\":\"https://x.com/TDCCPMEME\",\"website\":\"https://tdccpmeme.pw/\",\"telegram\":\"https://t.me/TDCCP_official\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreie6rfsb43nvuuqay3k362v4lamyxr7b4ll6jl6ejhv2dpyewuck2i"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TDCCP>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TDCCP>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TDCCP>>(0x2::coin::mint<TDCCP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}


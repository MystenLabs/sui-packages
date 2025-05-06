module 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"KAKA";
        let (v1, v2) = 0x2::coin::create_currency<KAKA>(arg0, 2, v0, b"KAKA", b"KAKA serves as the daily-use token within the DAKA Value Network, enabling users to purchase goods/services across partnered platforms. Integrated with loyalty rewards and instant settlement features, it powers frictionless consumer transactions while incentivizing engagement through redeemable discounts and exclusive membership perks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreidajhyhxcw6moknznsdcdshblxytju7quer46ivh7ddjstputs6jy")), arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::create_token<KAKA>(@0x3f2620474648cb8f054e65dac2723c3253922a9181db7d3edd7cf4fa830c3a73, v0, 0x2::tx_context::sender(arg1), v1, v2, 18446744073709551615, arg1);
    }

    public(friend) fun mint<T0: copy + drop>(arg0: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<KAKA>, arg1: &mut 0x2::coin::TreasuryCap<KAKA>, arg2: u64, arg3: address, arg4: u16, arg5: 0x1::string::String, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::mint_transfer<KAKA, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun public_mint(arg0: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<KAKA>, arg1: &mut 0x2::coin::TreasuryCap<KAKA>, arg2: u64, arg3: address, arg4: u16, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        mint<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::EventTip>(arg0, arg1, arg2, arg3, arg4, arg5, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::new_event_tip(arg6), arg7);
    }

    // decompiled from Move bytecode v6
}


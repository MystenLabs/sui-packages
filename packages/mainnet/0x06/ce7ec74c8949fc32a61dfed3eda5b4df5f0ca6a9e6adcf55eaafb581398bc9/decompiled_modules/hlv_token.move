module 0x6ce7ec74c8949fc32a61dfed3eda5b4df5f0ca6a9e6adcf55eaafb581398bc9::hlv_token {
    struct HLV_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLV_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HLV_TOKEN>(arg0, 6, 0x1::string::utf8(b"HLV"), 0x1::string::utf8(b"Helevision"), 0x1::string::utf8(b"Utility and rewards token for the Helevision streaming ecosystem."), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeih6qagtqgejthx4t5zc4rhye7j5iloxosi55indljnwyrwzj74ddq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<HLV_TOKEN>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HLV_TOKEN>>(0x2::coin_registry::finalize<HLV_TOKEN>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<HLV_TOKEN>>(0x2::coin::mint<HLV_TOKEN>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


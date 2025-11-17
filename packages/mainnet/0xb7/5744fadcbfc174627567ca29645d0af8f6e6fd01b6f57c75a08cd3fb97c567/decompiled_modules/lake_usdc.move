module 0xb75744fadcbfc174627567ca29645d0af8f6e6fd01b6f57c75a08cd3fb97c567::lake_usdc {
    struct LakeUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable_vault<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LakeUSDC>(arg0, decimals(), 0x1::string::utf8(b"lakeUSDC"), 0x1::string::utf8(b"lakeUSDC"), 0x1::string::utf8(b"Yield-bearing USDC issued by lake.inc"), 0x1::string::utf8(b"https://aqua-natural-grasshopper-705.mypinata.cloud/ipfs/bafkreiggf6g2e7wuutqd53juosqvlsc6flw2bqbnhnda4fxg75iyxiys4m"), arg3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LakeUSDC>>(0x2::coin_registry::finalize<LakeUSDC>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::default_create<LakeUSDC, T0, T1>(arg1, v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg3), arg2, arg3);
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}


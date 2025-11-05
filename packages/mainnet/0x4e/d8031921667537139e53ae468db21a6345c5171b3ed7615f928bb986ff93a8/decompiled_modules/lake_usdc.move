module 0x4ed8031921667537139e53ae468db21a6345c5171b3ed7615f928bb986ff93a8::lake_usdc {
    struct LakeUSDC has key {
        id: 0x2::object::UID,
    }

    public fun create_stable_vault<T0, T1>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &0xfef3f19325ccb92b47b4b5ce9eac94a66dde2013518a55302de2fe24d1146995::stable_vault::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LakeUSDC>(arg0, decimals(), 0x1::string::utf8(b"lakeUSDC"), 0x1::string::utf8(b"Lake USDC"), 0x1::string::utf8(b"Yield-bearing USDC issued by lake.money"), 0x1::string::utf8(b"https://circle.com/usdc-icon"), arg2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LakeUSDC>>(0x2::coin_registry::finalize<LakeUSDC>(v0, arg2), 0x2::tx_context::sender(arg2));
        0xfef3f19325ccb92b47b4b5ce9eac94a66dde2013518a55302de2fe24d1146995::stable_vault::default_create<LakeUSDC, T0, T1>(arg1, v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg2), arg2);
    }

    public fun decimals() : u8 {
        6
    }

    // decompiled from Move bytecode v6
}


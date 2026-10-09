module 0x66f6e5bc4974932455e18a1a8d2ec7b2b43117416eed2942910482ac379a2cf0::af_lp_b {
    struct AF_LP_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP_B, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::create_pool_cap_and_set_decimals<AF_LP_B>(arg0, b"Blast E2E LP B", b"BLASTE2ELPB", b"Aftermath LP coin for a Blast presale E2E sale", 0x1::option::none<0x2::url::Url>(), 0x1::option::none<vector<u8>>(), false, vector[], 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


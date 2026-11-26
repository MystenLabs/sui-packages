module 0xc95501f00517f24f1210b91d607fab55294a80e7b287e8c29992bca791ca1204::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 200000000000000000);
        0x1::vector::push_back<u64>(v1, 800000000000000000);
        0x2::transfer::public_transfer<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::create_pool_cap_and_set_decimals<AF_LP>(arg0, b"KARES-SUI-LP", b"KARES SUI Aftermath LP", b"Aftermath LP coin for the KARES/SUI pool.", 0x1::option::none<0x2::url::Url>(), 0x1::option::some<vector<u8>>(x"0909"), true, v0, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


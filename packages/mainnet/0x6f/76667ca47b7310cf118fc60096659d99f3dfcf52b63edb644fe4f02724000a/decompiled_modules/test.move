module 0x6f76667ca47b7310cf118fc60096659d99f3dfcf52b63edb644fe4f02724000a::test {
    public fun just_test_1() : 0x1::type_name::TypeName {
        0x1::type_name::get<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>()
    }

    public fun just_test_2() : 0x1::type_name::TypeName {
        0x1::type_name::get<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>()
    }

    public fun just_test_3() : 0x1::type_name::TypeName {
        0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()
    }

    public fun just_test_4() : 0x1::type_name::TypeName {
        0x1::type_name::get<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>()
    }

    public fun just_test_5() : 0x1::type_name::TypeName {
        0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>()
    }

    public fun just_test_6() : 0x1::type_name::TypeName {
        0x1::type_name::get<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>()
    }

    // decompiled from Move bytecode v6
}


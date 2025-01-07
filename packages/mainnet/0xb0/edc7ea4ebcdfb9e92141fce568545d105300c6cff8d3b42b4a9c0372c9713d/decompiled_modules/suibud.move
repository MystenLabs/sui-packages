module 0xb0edc7ea4ebcdfb9e92141fce568545d105300c6cff8d3b42b4a9c0372c9713d::suibud {
    struct SUIBUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUD>(arg0, 6, b"SUIBUD", b"SUIBUD (The Buddy Boys Club)", x"245355494255442049732054686520556e636c65204f6620427564647920426f797320436c7562204b69647320506570652c2042726574742c20416e647920616e64204c616e64776f6c662e0a4865204c6f76657320546f2053746179205269636820416e6420456e6a6f7920546865205765616c7468205769746820467269656e6473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241013_064042_07c39b1839.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUD>>(v1);
    }

    // decompiled from Move bytecode v6
}


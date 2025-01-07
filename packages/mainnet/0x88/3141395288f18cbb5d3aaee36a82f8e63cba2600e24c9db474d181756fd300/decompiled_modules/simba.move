module 0x883141395288f18cbb5d3aaee36a82f8e63cba2600e24c9db474d181756fd300::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"SIMBA", b"SIMBA the Sloth on Sui", x"546865206d656d6520636f696e20746861742063656c6562726174657320736c6f7720616e64207374656164792067726f7774682c20726577617264696e672070617469656e63650a696e206120666173742d70616365642063727970746f20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/about_elem_0f67f32cfa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}


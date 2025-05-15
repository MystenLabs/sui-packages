module 0x7a928f261fbaa933cfe0eeef5ccea4108dca3a24b32b94765a3edf3a1d37581e::phnux {
    struct PHNUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHNUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHNUX>(arg0, 6, b"PHNUX", b"Phnux", x"5075736865642066726f6d20746865206e65737420627574206261636b20666f72207468652063726f776e2e202450484e55582069732074686520537569277320747275652073796d626f6c206f6620726573696c69656e6365202d207769746820616464656420726562656c6c696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/50484e5558000000000000000000000000000000_r4ejwut3fb6unbjtp1l6pchhr5111eblct_457d5c39b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHNUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHNUX>>(v1);
    }

    // decompiled from Move bytecode v6
}


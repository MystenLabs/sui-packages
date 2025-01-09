module 0xcd77359f46b5a44000ae692abf42abd4fdeaa54d3797c1c0c46fcfd47e91a72c::sopod {
    struct SOPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPOD>(arg0, 6, b"Sopod", b"Sopod AI", x"233120414920576174636820205765617220536f706f64204f5320687474703a2f2f736f706f642e61690a4149202b20446550494e3a2041204e657720457261206f66204175746f6e6f6d792e20506f77657265642062792074686520636f6d6d756e69747920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4fm_Wx_E7_N_400x400_1_a09363c16f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x98239a32f3141bd9870f6857f84683e93b4fb2c3db936e1311cc23a7d4c39d4e::ouroborosui {
    struct OUROBOROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUROBOROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OUROBOROSUI>(arg0, 6, b"OUROBOROSUI", b"OUROBOROS", x"496e2074686520656d6272616365206f66204f75726f626f726f732c207468657265206c69657320612070726f666f756e6420776973646f6d2e200a54686572652063616e206265206e6f206c69666520776974686f75742064656174682c20616e64206e6f206d696e7420776974686f7574206275726e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Opera_Instant_A_neo_2024_10_17_022952_x_com_9ce219fe30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OUROBOROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OUROBOROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


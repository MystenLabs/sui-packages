module 0xae2fe08f4e18f172a6d35fedd959b8df163951356c04e1e63b65e06d58e8b2dd::beesui {
    struct BEESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEESUI>(arg0, 6, b"BEESUI", b"BEE SUI", x"576520617265202442454520666f72207468652070656f706c652e2020200a0a5468652062656520686173206465636964656420746f20636f6d62696e652069747320686f6e6579207769746820776174657220616e64206f6666657220657863656c6c656e742062656e65666974732e0a0a54686520737765657465737420746f6b656e206f6e205375692e204f757220636f6d6d756e69747920697320626f6e6420746f676574686572207769746820686f6e65792e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_1_a6c4591c4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


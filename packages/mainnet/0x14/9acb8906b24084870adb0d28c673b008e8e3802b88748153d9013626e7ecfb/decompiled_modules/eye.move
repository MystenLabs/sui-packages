module 0x149acb8906b24084870adb0d28c673b008e8e3802b88748153d9013626e7ecfb::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"EYE Am Watching You", x"596f752077616e7420746f206d616b65206d6f6e65792c2072696768743f20446f6e27742070726574656e6420796f75277265206e6f74206865726520666f7220746861742e2e2e207765207365652065766572797468696e672e20596f75207468696e6b20796f75726520696e20636f6e74726f6c2c206275742072656d656d6265723a2054686520457965206973207761746368696e67206576657279206d6f766520796f75206d616b652e205768617420646f20796f75207468696e6b20796f75726520646f696e673f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L4ny_Cg_Rn_400x400_139e1d8459.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7e8ecb06ecf178a47e903bdf4903033eec89820c94689a3a9c4e7d3d76b10fd5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, b"SUIPUMP", b"SUI PUMP", x"4c61796572203120626c6f636b636861696e2064657369676e656420746f206d616b65206469676974616c206173736574206f776e65727368697020666173742c20707269766174652c207365637572652c20616e642061636365737369626c6520746f2065766572796f6e652e2054776974746572206279200a40537569466f756e646174696f6e0a2e2052542020656e646f7273656d656e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZY_Gb_Rk_Xw_A_Au6n_M_594c5cff95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


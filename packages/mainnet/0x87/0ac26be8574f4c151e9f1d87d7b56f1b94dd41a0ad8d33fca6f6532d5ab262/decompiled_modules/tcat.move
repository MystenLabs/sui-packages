module 0x870ac26be8574f4c151e9f1d87d7b56f1b94dd41a0ad8d33fca6f6532d5ab262::tcat {
    struct TCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCAT>(arg0, 6, b"TCAT", b"Troller Cat", x"54726f6c6c6572204361746d61700a546865204d617374657220506c616e2028546f74616c6c79204e6f7420447261776e20696e20437261796f6e290a0a24544341542069736e74206a75737420616e6f74686572206d656d6520666c79696e67207468726f756768207468652063727970746f20766f69647765766520676f7420636c61777320616e64206120706c616e2e20546869732069736e7420666c7566662e20497473206120726f61646d6170206275696c7420666f72206368616f732c20657870616e73696f6e2c20616e642073746179696e6720706f776572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250509_024130_c24bcc6ff4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


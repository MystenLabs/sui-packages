module 0xeb192fc39de9327b09138f086864ac1662843b70f2c11e345a75ec761cb5c432::suipiens {
    struct SUIPIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIENS>(arg0, 6, b"Suipiens", b"Sui piens", x"4f4720436f6d6d756e697479206f6e20245375692045636f73797374656d2e20200a536861726520746865206e6577732c20737472617465677920746f206275696c6420796f7572207765616c7468206f6e200a407375696e6574776f726b0a200a234275696c644f6e5375692020687474703a2f2f6c696e6b74722e65652f7375697069656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_Sx_W_Miq_T_400x400_09c84935e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}


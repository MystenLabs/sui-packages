module 0xd1e9d8a9a84347ce14e1fc4778c5335c31ee6ac761603276b9f51361d82a1283::teftel {
    struct TEFTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEFTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEFTEL>(arg0, 6, b"TEFTEL", b"Cat Teftel", x"506176656c204475726f7673206669727374207075626c69632070726573656e746174696f6e20617420546f6b656e323034392077686572652068652073756767657374656420746861742054656c656772616d20737469636b657273206861766520677265617420706f74656e7469616c20746f206265636f6d6520636f6d6d756e6974792d706f7765726564206d656d6520636f696e732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vg_Uxo9_TF_400x400_40fc9bb72b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEFTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEFTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}


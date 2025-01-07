module 0x857c38c5a922e1283027686b863299c43567f50a00053ad68921a982e08a3971::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Adansonia", x"5468652062616f62616220747265652c206120746f776572696e67206769616e742074726565207573656420696e7465726e616c6c7920746f2073746f7265207661737420616d6f756e7473206f66207761746572207265736f75726365732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/houmianbao_37d3a302d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADA>>(v1);
    }

    // decompiled from Move bytecode v6
}


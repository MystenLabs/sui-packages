module 0x3632eb8fc9777720c03bb73bb80143f2958f6cad3200b5f97aa0b3bde20da646::suiyawn {
    struct SUIYAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAWN>(arg0, 6, b"SUIYAWN", b"SUI YAWN", x"4c415a592046555252494520434841524143544552200a0a4d656574205961776e2c20746865206c617a696573742c206d6f7374206c6169642d6261636b2063686172616374657220696e207468652063727970746f20756e6976657273652e205961776e2077696c6c206272696e672066696e616e6369616c2066726565646f6d20666f7220657665727920686f6c646572732e20427579206e6f7720616e6420676574207269636820746f676574686572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3499_b2cb0c04fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}


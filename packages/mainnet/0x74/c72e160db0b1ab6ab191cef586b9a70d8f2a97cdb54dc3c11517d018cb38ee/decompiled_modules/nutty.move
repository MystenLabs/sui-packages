module 0x74c72e160db0b1ab6ab191cef586b9a70d8f2a97cdb54dc3c11517d018cb38ee::nutty {
    struct NUTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTTY>(arg0, 6, b"NUTTY", b"Nutty", x"4e55545459204953204120444547454e455241544520424f4e4720534d4f4b494e472c20484f452050494d50494e472c204c414d424f2044524956494e4720535155495252454c2054484154204c4f56455320544f204d554e4348204f4e204e5554532e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nutty_Logo_d4bcffeebb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}


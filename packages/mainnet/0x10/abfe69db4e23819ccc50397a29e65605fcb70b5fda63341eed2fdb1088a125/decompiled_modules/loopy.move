module 0x10abfe69db4e23819ccc50397a29e65605fcb70b5fda63341eed2fdb1088a125::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 6, b"LOOPY", b"LOOPY S", x"2d204c4f4f5059202d0a546865206c6174657374206d656d650a63727970746f63757272656e637920746f206869742074686520626c6f636b636861696e0a696e737069726564206279207468652061646f7261626c650a616e642067656e746c652d68656172746564204c6f6f70792066726f6d0a7468652062656c6f7665642022506f726f726f20746865204c6974746c652050656e6775696e22207365726965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/33395_5612038a18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


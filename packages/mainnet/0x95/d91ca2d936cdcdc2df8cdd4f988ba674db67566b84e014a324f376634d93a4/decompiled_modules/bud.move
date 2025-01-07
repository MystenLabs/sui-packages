module 0x95d91ca2d936cdcdc2df8cdd4f988ba674db67566b84e014a324f376634d93a4::bud {
    struct BUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUD>(arg0, 6, b"BUD", b"BudBot", x"427564426f7420697320746865206661737465737420616e64206d6f73742073656375726520636f70792074726164696e6720626f74206f6e20245355492c206275696c7420746f2068656c702074726164657273206f6620616c6c20657870657269656e6365206c6576656c73206d6178696d697a652074686569722070726f666974732e200a0a486f6c64657273206561726e20726576656e75652073686172652066726f6d2074726164696e6720666565732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734200582513.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


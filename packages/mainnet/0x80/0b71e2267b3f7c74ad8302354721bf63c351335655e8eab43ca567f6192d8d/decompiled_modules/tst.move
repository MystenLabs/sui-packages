module 0x800b71e2267b3f7c74ad8302354721bf63c351335655e8eab43ca567f6192d8d::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"TST", b"Test", b"Just test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://touch.ninosaur.com/coloring/files/art-original/angry-birds-8bit-bomb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


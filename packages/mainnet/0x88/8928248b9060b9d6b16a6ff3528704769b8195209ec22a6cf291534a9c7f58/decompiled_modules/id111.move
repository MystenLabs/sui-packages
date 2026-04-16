module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::id111 {
    struct ID111 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ID111>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ID111>>(0x2::coin::mint<ID111>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ID111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ID111>(arg0, 9, b"ID111", b"ID Identity", x"4964656e7469747920746f6b656e20e28094204669626f6e6163636920737570706c793a203134342e20496e737572616e63653a203130306270732e2058616861753a20727344374342316e6277333432597863354b376133753551547743515a37554b4156", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/id111.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ID111>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ID111>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


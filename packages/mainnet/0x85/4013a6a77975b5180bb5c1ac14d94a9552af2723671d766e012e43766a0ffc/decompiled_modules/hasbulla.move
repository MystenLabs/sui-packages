module 0x854013a6a77975b5180bb5c1ac14d94a9552af2723671d766e012e43766a0ffc::hasbulla {
    struct HASBULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBULLA>(arg0, 6, b"HASBULLA", b"Hasbulla on SUI", x"48415342554c4c4120697320746865206e65776573742063727970746f63757272656e637920696e737069726564206279207468652066616d6f757320696e7465726e65742073656e736174696f6e2c2048617362756c6c61204d61676f6d65646f762e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HAS_B_f9b262af2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc7a06cf29d0fa8e1fc6a039ec546e6ed326f94ebdc9320f491737ec94ea2b34c::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"LEN", b"LEN COIN", x"496e74726f647563696e67204c454e434f494e206f6e2053554920244c454e2c20746865206f6e6c79206d656d6520636f696e20696e737069726564206279207468652063727970746f677261706879206c6567656e642068696d73656c660a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_00_24_12_2efb9495b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


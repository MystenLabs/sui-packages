module 0x577b33c7f265c6bb3e0941c987497ae7fa177a536ac224e402abad9115554b2c::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"SRM", b"Squirrelman", x"5468652077617220697320636f6d696e6720736f6f6e2c20616e6420537175697272656c6d616e206973207374726f6e6720656e6f75676820746f206272696e672074686520766f74652074726f6f707320746f205472756d70204c6f6f6b20576861742048617070656e65640a566963746f727920696e20746865206c656164206f66202453524d200a5472756d702074686520656c656374696f6e2077696e6e65720a566f74652077696c6c2062652068656c64206d6f726520627920537175697272656c6d616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044555_800ee5c58c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRM>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xad180e37be36ffa69f76310c34d6f8812c85d929f670af97a3b3e198cf42d1b9::happycat {
    struct HAPPYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPYCAT>(arg0, 6, b"HAPPYCAT", b"Happy Cat", x"4861707079204361742028244841505059434154290a496e206120717561696e7420636f747461676520627920746865207365612c2046656c69782c20746865207461626279206361742c207370656e74206869732064617973206261736b696e6720696e207468652073756e6c6967687420616e642063686173696e672073656167756c6c20736861646f77732e205769746820612066756c6c2062656c6c7920616e6420612066616d696c792773206c6f76652c206865207075727265642068697320776179207468726f75676820656163682070657266656374206461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/777_672f50b33d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPPYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


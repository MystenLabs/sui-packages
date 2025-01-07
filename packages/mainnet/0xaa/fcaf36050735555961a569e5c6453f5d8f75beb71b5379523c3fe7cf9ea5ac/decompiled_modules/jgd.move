module 0xaafcaf36050735555961a569e5c6453f5d8f75beb71b5379523c3fe7cf9ea5ac::jgd {
    struct JGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGD>(arg0, 6, b"JGD", b"Joy giver", x"49206d616b6520776f6d656e2068617070792e0a49276d20746865206a6f7920676976657220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000117562_6508d13aa8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JGD>>(v1);
    }

    // decompiled from Move bytecode v6
}


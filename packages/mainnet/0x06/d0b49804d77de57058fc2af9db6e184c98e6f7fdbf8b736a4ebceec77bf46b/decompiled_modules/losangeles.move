module 0x6d0b49804d77de57058fc2af9db6e184c98e6f7fdbf8b736a4ebceec77bf46b::losangeles {
    struct LOSANGELES has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSANGELES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSANGELES>(arg0, 6, b"LOSANGELES", b"LOS ANGELES", x"4c4f5320414e47454c4553200a3330746820617474656d70742e203730252073656c6c202d2033302520627579207374726174656779", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020382_bb2f3a6b5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSANGELES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOSANGELES>>(v1);
    }

    // decompiled from Move bytecode v6
}


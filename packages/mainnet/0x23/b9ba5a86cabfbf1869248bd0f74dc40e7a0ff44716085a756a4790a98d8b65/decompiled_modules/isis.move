module 0x23b9ba5a86cabfbf1869248bd0f74dc40e7a0ff44716085a756a4790a98d8b65::isis {
    struct ISIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISIS>(arg0, 6, b"ISIS", b"ISuIS", x"416c6c61687520416b62617221200a42726f74686572732c205468652074696d65206861766520636f6d6521205765207368616c6c2076656e74757265206f6e20746865206a6f75726e657920746f776172647320776f726c6420646f6d696e6174696f6e20746f67657468657221200a0a416c6c61682077696c6c2073686f77207573207468652077617920746f204d6f6f6e656368612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flag_of_Jihad_svg_b825195714.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISIS>>(v1);
    }

    // decompiled from Move bytecode v6
}


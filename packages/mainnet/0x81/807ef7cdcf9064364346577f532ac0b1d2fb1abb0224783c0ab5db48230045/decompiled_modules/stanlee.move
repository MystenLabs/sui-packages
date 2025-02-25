module 0x81807ef7cdcf9064364346577f532ac0b1d2fb1abb0224783c0ab5db48230045::stanlee {
    struct STANLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STANLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANLEE>(arg0, 9, b"STANLEE", b"Stan Lee", b"Stan Lee was an American comic book writer, editor, publisher, and producer. He rose through the ranks of a family-run business called Timely Comics which later became Marvel Comics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/7/7b/Stan_Lee_by_Gage_Skidmore_3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STANLEE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STANLEE>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STANLEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

